module Users::Operation
  class Show < Panicboat::Operation
    step Model(::User, :find_by)
    step Contract::Build(constant: Users::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist(method: :sync)
  end
end
