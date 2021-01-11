module Roles::Operation
  class Update < Abstract::Operation
    step Model(::Role, :find_by)
    step Contract::Build(constant: Roles::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step Contract::Persist()
  end
end
