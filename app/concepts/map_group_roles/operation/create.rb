module MapGroupRoles::Operation
  class Create < Panicboat::Operation
    step Model(::MapGroupRole, :new)
    step Contract::Build(constant: MapGroupRoles::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
