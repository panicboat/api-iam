module MapGroupPolicies::Operation
  class Index < Abstract::Operation
    step Model(::MapGroupPolicy)
    step Contract::Build(constant: MapGroupPolicies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::MapGroupPolicy.where({ group_id: contract.group_id }).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ MapGroupPolicies: data })
    end
  end
end
