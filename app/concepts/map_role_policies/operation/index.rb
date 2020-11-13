module MapRolePolicies::Operation
  class Index < Abstract::Operation
    step Model(::MapRolePolicy)
    step Contract::Build(constant: MapRolePolicies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = ::MapRolePolicy.where({ role_id: contract.role_id }).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ MapRolePolicies: data })
    end
  end
end
