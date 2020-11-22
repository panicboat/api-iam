module Groups::Operation
  class Update < Panicboat::Operation
    step Model(::Group, :find_by)
    step Contract::Build(constant: Groups::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
