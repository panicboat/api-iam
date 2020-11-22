module MapRolePolicies::Operation
  class Destroy < Panicboat::Operation
    step Model(::MapRolePolicy)
    step Contract::Build(constant: MapRolePolicies::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, **)
      contract = contract(ctx)
      data = ::MapRolePolicy.find_by({ role_id: contract.role_id, policy_id: contract.policy_id })
      data.destroy
      ctx[:model] = data
    end
  end
end
