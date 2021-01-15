module MapGroupRoles::Operation
  class Index < Abstract::Operation
    step Model(::MapGroupRole)
    step Contract::Build(constant: MapGroupRoles::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      data = data.where({ group_id: contract.group_id }) if contract.group_id.present?
      ctx[:model] = OpenStruct.new({ MapGroupRoles: data })
    end
  end
end
