module Groups::Operation
  class Show < Abstract::Operation
    step Model(::Group, :find_by)
    step Contract::Build(constant: Groups::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step Contract::Persist(method: :sync)
  end
end
