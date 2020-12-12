module MapUserPolicies::Operation
  class Index < Abstract::Operation
    step Model(::MapUserPolicy)
    step Contract::Build(constant: MapUserPolicies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::MapUserPolicy.where({ user_id: contract.user_id }).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ MapUserPolicies: data })
    end
  end
end
