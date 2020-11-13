module Services::Operation
  class Destroy < Abstract::Operation
    step Model(::Service, :find_by)
    step Contract::Build(constant: Services::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, model:, **)
      model.destroy
    end
  end
end
