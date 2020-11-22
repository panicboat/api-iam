module Policies::Operation
  class Destroy < Abstract::Operation
    step Model(::Policy, :find_by)
    step Contract::Build(constant: Policies::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, model:, **)
      model.destroy
      ctx[:model] = Concerns::Show.new(model).model
    end
  end
end
