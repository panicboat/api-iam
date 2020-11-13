module Groups::Operation
  class Destroy < Abstract::Operation
    step Model(::Group, :find_by)
    step Contract::Build(constant: Groups::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, model:, **)
      model.destroy
    end
  end
end
