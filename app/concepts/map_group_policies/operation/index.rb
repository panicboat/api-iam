module MapGroupPolicies::Operation
  class Index < Abstract::Operation
    step Model(::MapGroupPolicy)
    step Contract::Build(constant: MapGroupPolicies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      data = data.where({ group_id: contract.group_id }) if contract.group_id.present?
      ctx[:model] = OpenStruct.new({ MapGroupPolicies: data })
    end
  end
end
