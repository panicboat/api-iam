module MapUserRoles::Operation
  class Destroy < Panicboat::Operation
    step Model(::MapUserRole)
    step Contract::Build(constant: MapUserRoles::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :model!

    def model!(ctx, **)
      contract = contract(ctx)
      data = ::MapUserRole.find_by({ user_id: contract.user_id, role_id: contract.role_id })
      data.destroy
      ctx[:model] = data
    end
  end
end
