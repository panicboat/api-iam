module Groups::Operation
  class Index < Abstract::Operation
    step Model(::Group)
    step Contract::Build(constant: Groups::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Groups: data })
    end
  end
end
