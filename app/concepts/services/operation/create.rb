module Services::Operation
  class Create < Panicboat::Operation
    step Model(::Service, :new)
    step Contract::Build(constant: Services::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :uuid!
    step Contract::Persist()
  end
end
