require 'net/http'

class TokenManager
  def initialize(jwt)
    @jwt = jwt
    @payload = ::JWT.decode(jwt, nil, false)
  end

  def decode
    return nil if payload[0]['iss'] != "https://cognito-idp.#{ENV['AWS_DEFAULT_REGION']}.amazonaws.com/#{ENV['AWS_COGNITO_USERPOOL_ID']}"

    case payload[0]['token_use']
    when 'id'
      id(jwt, jwks, payload)
    when 'access'
      access(payload)
    end
  end

  private

  attr_reader :jwt, :payload

  def jwks
    uri = "https://cognito-idp.#{ENV['AWS_DEFAULT_REGION']}.amazonaws.com/#{ENV['AWS_COGNITO_USERPOOL_ID']}/.well-known/jwks.json"
    response = ::Net::HTTP.get_response(::URI.parse(uri))
    ::JSON.parse(response.body).with_indifferent_access
  end

  def id(jwt, jwks, payload)
    modulus = bn(jwks[:keys][0][:n])
    exponent = bn(jwks[:keys][0][:e])
    sequence = ::OpenSSL::ASN1::Sequence.new([::OpenSSL::ASN1::Integer.new(modulus), ::OpenSSL::ASN1::Integer.new(exponent)])
    ::JWT.decode jwt, ::OpenSSL::PKey::RSA.new(sequence.to_der), true, algorithm: payload[1]['alg']
  end

  def access(payload)
    return nil if ::Time.zone.now.to_i > payload[0]['exp']

    payload
  end

  def bn(n)
    n += '=' * (4 - n.size % 4) if n.size % 4 != 0
    decoded = ::Base64.urlsafe_decode64 n
    unpacked = decoded.unpack1('H*')
    ::OpenSSL::BN.new unpacked, 16
  end
end
