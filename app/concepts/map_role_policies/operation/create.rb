module MapRolePolicies::Operation
  class Create < Abstract::Operation
    step Model(::MapRolePolicy, :new)
    step Contract::Build(constant: MapRolePolicies::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
