module MapUserPolicies::Operation
  class Create < Abstract::Operation
    step Model(::MapUserPolicy, :new)
    step Contract::Build(constant: MapUserPolicies::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step Contract::Persist()
  end
end
