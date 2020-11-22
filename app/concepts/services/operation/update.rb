module Services::Operation
  class Update < Panicboat::Operation
    step Model(::Service, :find_by)
    step Contract::Build(constant: Services::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
