module Policies::Operation
  class Create < Abstract::Operation
    step Model(::Policy, :new)
    step Contract::Build(constant: Policies::Contract::Create)
    step Contract::Validate()
    fail :invalid_params!
    step :uuid!
    step Contract::Persist()
    step :model!

    def model!(ctx, model:, **)
      Concerns::Refresh.new(contract(ctx).statements).save!(model)
      ctx[:model] = Concerns::Show.new(model).model
    end
  end
end
