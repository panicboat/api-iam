module MapGroupUsers::Operation
  class Create < Panicboat::Operation
    step Model(::MapGroupUser, :new)
    step Contract::Build(constant: MapGroupUsers::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
