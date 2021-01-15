module MapGroupRoles::Operation
  class Create < Abstract::Operation
    step Model(::MapGroupRole, :new)
    step Contract::Build(constant: MapGroupRoles::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step Contract::Persist()
  end
end
