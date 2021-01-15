module MapGroupPolicies::Operation
  class Create < Abstract::Operation
    step Model(::MapGroupPolicy, :new)
    step Contract::Build(constant: MapGroupPolicies::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step Contract::Persist()
  end
end
