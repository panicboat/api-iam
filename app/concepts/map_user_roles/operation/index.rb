module MapUserRoles::Operation
  class Index < Abstract::Operation
    step Model(::MapUserRole)
    step Contract::Build(constant: MapUserRoles::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      data = data.where({ user_id: contract.user_id }) if contract.user_id.present?
      ctx[:model] = OpenStruct.new({ MapUserRoles: data })
    end
  end
end
