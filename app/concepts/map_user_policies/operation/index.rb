module MapUserPolicies::Operation
  class Index < Abstract::Operation
    step Model(::MapUserPolicy)
    step Contract::Build(constant: MapUserPolicies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      data = data.where({ user_id: contract.user_id }) if contract.user_id.present?
      ctx[:model] = OpenStruct.new({ MapUserPolicies: data })
    end
  end
end
