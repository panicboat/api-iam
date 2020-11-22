module Users::Operation
  class Update < Panicboat::Operation
    step Model(::User, :find_by)
    step Contract::Build(constant: Users::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
