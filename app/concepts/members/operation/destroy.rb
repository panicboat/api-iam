module Members::Operation
  class Destroy < Abstract::Operation
    step Model(::Member, :find_by)
    step Contract::Build(constant: Members::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, model:, **)
      model.destroy
    end
  end
end
