module Services::Operation
  class Update < Abstract::Operation
    step Model(::Service, :find_by)
    step Contract::Build(constant: Services::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step Contract::Persist()
  end
end
