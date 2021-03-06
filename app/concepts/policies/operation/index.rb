module Policies::Operation
  class Index < Abstract::Operation
    step Model(::Policy)
    step Contract::Build(constant: Policies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Policies: data })
    end
  end
end
