module Actions::Operation
  class Update < Abstract::Operation
    step Model(::Action, :find_by)
    step Contract::Build(constant: Actions::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step Contract::Persist()
  end
end
