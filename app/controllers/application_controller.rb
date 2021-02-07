class ApplicationController < Panicboat::AbstractController
  private

  def _session(headers)
    jwt = headers.authorization[::RequestHeader::USER_CLAIMS]
    return nil if jwt.blank?

    data = ::TokenManager.new(jwt).decode
    return nil if data.blank?

    ::User.find_by(email: data.first['email'])
  end
end
