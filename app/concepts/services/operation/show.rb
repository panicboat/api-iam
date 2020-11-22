module Services::Operation
  class Show < Panicboat::Operation
    step Model(::Service, :find_by)
    step Contract::Build(constant: Services::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist(method: :sync)
  end
end
