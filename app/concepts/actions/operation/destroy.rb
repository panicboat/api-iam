module Actions::Operation
  class Destroy < Panicboat::Operation
    step Model(::Action, :find_by)
    step Contract::Build(constant: Actions::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, model:, **)
      model.destroy
    end
  end
end
