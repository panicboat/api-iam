module MapGroupPolicies::Operation
  class Destroy < Panicboat::Operation
    step Model(::MapGroupPolicy)
    step Contract::Build(constant: MapGroupPolicies::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, **)
      contract = contract(ctx)
      data = ::MapGroupPolicy.find_by({ group_id: contract.group_id, policy_id: contract.policy_id })
      data.destroy
      ctx[:model] = data
    end
  end
end
