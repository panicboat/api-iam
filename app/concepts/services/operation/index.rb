module Services::Operation
  class Index < Abstract::Operation
    step Model(::Service)
    step Contract::Build(constant: Services::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = ::Service.paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Services: data })
    end
  end
end
