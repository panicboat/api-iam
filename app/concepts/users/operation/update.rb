module Users::Operation
  class Update < Abstract::Operation
    step Model(::User, :find_by)
    step Contract::Build(constant: Users::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step Contract::Persist()
  end
end
