module MapUserRoles::Operation
  class Create < Abstract::Operation
    step Model(::MapUserRole, :new)
    step Contract::Build(constant: MapUserRoles::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
