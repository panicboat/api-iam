module Roles::Operation
  class Update < Panicboat::Operation
    step Model(::Role, :find_by)
    step Contract::Build(constant: Roles::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
  end
end
