module Actions::Operation
  class Index < Abstract::Operation
    step Model(::Action)
    step Contract::Build(constant: Actions::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Actions: data })
    end
  end
end
