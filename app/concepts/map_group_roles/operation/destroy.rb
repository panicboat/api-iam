module MapGroupRoles::Operation
  class Destroy < Abstract::Operation
    step Model(::MapGroupRole)
    step Contract::Build(constant: MapGroupRoles::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step :model!

    def model!(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::MapGroupRole.find_by({ group_id: contract.group_id, role_id: contract.role_id })
      data.destroy
      ctx[:model] = data
    end
  end
end
