module Policies::Operation
  class Update < Panicboat::Operation
    step Model(::Policy, :find_by)
    step Contract::Build(constant: Policies::Contract::Update)
    step Contract::Validate()
    fail :invalid_params!
    step Contract::Persist()
    step :model!

    def model!(ctx, model:, **)
      ::Statement.where({ policy_id: model.id }).each do |statements|
        statements.destroy
      end
      Concerns::Refresh.new(contract(ctx).statements).save!(model)
      ctx[:model] = Concerns::Show.new(model).model
    end
  end
end
