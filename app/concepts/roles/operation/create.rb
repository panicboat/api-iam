module Roles::Operation
  class Create < Panicboat::Operation
    step Model(::Role, :new)
    step Contract::Build(constant: Roles::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :uuid!
    step Contract::Persist()
  end
end
