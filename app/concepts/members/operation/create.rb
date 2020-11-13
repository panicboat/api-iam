module Members::Operation
  class Create < Abstract::Operation
    step Model(::Member, :new)
    step Contract::Build(constant: Members::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :uuid!
    step Contract::Persist()
  end
end
