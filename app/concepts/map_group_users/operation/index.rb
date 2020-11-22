module MapGroupUsers::Operation
  class Index < Abstract::Operation
    step Model(::MapGroupUser)
    step Contract::Build(constant: MapGroupUsers::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = ::MapGroupUser.where({ group_id: contract.group_id }).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ MapGroupUsers: data })
    end
  end
end
