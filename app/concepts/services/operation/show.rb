module Services::Operation
  class Show < Abstract::Operation
    step Model(::Service, :find_by)
    step Contract::Build(constant: Services::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step Contract::Persist(method: :sync)
  end
end
