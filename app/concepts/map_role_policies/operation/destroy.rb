module MapRolePolicies::Operation
  class Destroy < Abstract::Operation
    step Model(::MapRolePolicy)
    step Contract::Build(constant: MapRolePolicies::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step :model!

    def model!(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::MapRolePolicy.find_by({ role_id: contract.role_id, policy_id: contract.policy_id })
      data.destroy
      ctx[:model] = data
    end
  end
end
