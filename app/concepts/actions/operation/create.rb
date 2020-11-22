module Actions::Operation
  class Create < Panicboat::Operation
    step Model(::Action, :new)
    step Contract::Build(constant: Actions::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :uuid!
    step Contract::Persist()
  end
end
