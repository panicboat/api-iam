module MapUserRoles::Operation
  class Index < Panicboat::Operation
    step Model(::MapUserRole)
    step Contract::Build(constant: MapUserRoles::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = ::MapUserRole.where({ user_id: contract.user_id }).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ MapUserRoles: data })
    end
  end
end
