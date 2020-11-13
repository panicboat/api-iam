module MapGroupRoles::Operation
  class Index < Abstract::Operation
    step Model(::MapGroupRole)
    step Contract::Build(constant: MapGroupRoles::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = ::MapGroupRole.where({ group_id: contract.group_id }).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ MapGroupRoles: data })
    end
  end
end
