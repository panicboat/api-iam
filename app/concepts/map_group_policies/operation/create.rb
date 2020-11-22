module MapGroupPolicies::Operation
  class Create < Panicboat::Operation
    step Model(::MapGroupPolicy, :new)
    step Contract::Build(constant: MapGroupPolicies::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
