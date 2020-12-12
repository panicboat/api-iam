module Tokens::Operation
  class Index < Abstract::Operation
    step Model(::OpenStruct)
    step Contract::Build(constant: Tokens::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      payload = {
        "#{RequestHeader::USER_CLAIMS}": claim(ctx),
        "#{RequestHeader::ACCESS_TOKEN}": token(ctx)
      }
      ctx[:model] = OpenStruct.new({ Payload: payload })
    end

    def claim(ctx)
      jwt = ctx[:headers].authorization[RequestHeader::USER_CLAIMS]
      return nil if jwt.blank?

      ::TokenManager.new(jwt).decode(Rails.env.development?)  # TODO: Make it the optimum parameter
    end

    def token(ctx)
      jwt = ctx[:headers].authorization[RequestHeader::ACCESS_TOKEN]
      return nil if jwt.blank?

      ::TokenManager.new(jwt).decode(Rails.env.development?)  # TODO: Make it the optimum parameter
    end
  end
end
