module Services::Operation
  class Index < Abstract::Operation
    step Model(::Service)
    step Contract::Build(constant: Services::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Services: data })
    end
  end
end
