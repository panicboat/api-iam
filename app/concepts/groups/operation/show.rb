module Groups::Operation
  class Show < Panicboat::Operation
    step Model(::Group, :find_by)
    step Contract::Build(constant: Groups::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist(method: :sync)
  end
end
