module Roles::Operation
  class Show < Abstract::Operation
    step Model(::Role, :find_by)
    step Contract::Build(constant: Roles::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step Contract::Persist(method: :sync)
  end
end
