module Members::Operation
  class Show < Abstract::Operation
    step Model(::Member, :find_by)
    step Contract::Build(constant: Members::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist(method: :sync)
  end
end
