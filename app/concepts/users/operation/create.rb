module Users::Operation
  class Create < Panicboat::Operation
    step Model(::User, :new)
    step Contract::Build(constant: Users::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :uuid!
    step Contract::Persist()
  end
end
