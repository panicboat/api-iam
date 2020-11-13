module Members::Operation
  class Update < Abstract::Operation
    step Model(::Member, :find_by)
    step Contract::Build(constant: Members::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
