module MapUserPolicies::Operation
  class Destroy < Abstract::Operation
    step Model(::MapUserPolicy)
    step Contract::Build(constant: MapUserPolicies::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step :model!

    def model!(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::MapUserPolicy.find_by({ user_id: contract.user_id, policy_id: contract.policy_id })
      data.destroy
      ctx[:model] = data
    end
  end
end
