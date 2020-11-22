module MapUserPolicies::Operation
  class Create < Panicboat::Operation
    step Model(::MapUserPolicy, :new)
    step Contract::Build(constant: MapUserPolicies::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
