module Actions::Operation
  class Show < Abstract::Operation
    step Model(::Action, :find_by)
    step Contract::Build(constant: Actions::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist(method: :sync)
  end
end
