module Policies::Operation
  class Show < Panicboat::Operation
    step Model(::Policy, :find_by)
    step Contract::Build(constant: Policies::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, model:, **)
      ctx[:model] = Concerns::Show.new(model).model
    end
  end
end
