module MapGroupUsers::Operation
  class Create < Abstract::Operation
    step Model(::MapGroupUser, :new)
    step Contract::Build(constant: MapGroupUsers::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step Contract::Persist()
  end
end
