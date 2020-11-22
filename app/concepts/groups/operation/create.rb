module Groups::Operation
  class Create < Abstract::Operation
    step Model(::Group, :new)
    step Contract::Build(constant: Groups::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :uuid!
    step Contract::Persist()
  end
end
