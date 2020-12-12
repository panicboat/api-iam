module Users::Operation
  class Index < Abstract::Operation
    step Model(::User)
    step Contract::Build(constant: Users::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::User.paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Users: data })
    end
  end
end
