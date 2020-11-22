module Actions::Operation
  class Update < Panicboat::Operation
    step Model(::Action, :find_by)
    step Contract::Build(constant: Actions::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
