module Users::Operation
  class Destroy < Panicboat::Operation
    step Model(::User, :find_by)
    step Contract::Build(constant: Users::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, model:, **)
      model.destroy
    end
  end
end
