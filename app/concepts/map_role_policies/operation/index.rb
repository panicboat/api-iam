module MapRolePolicies::Operation
  class Index < Abstract::Operation
    step Model(::MapRolePolicy)
    step Contract::Build(constant: MapRolePolicies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      data = data.where({ role_id: contract.role_id }) if contract.role_id.present?
      ctx[:model] = OpenStruct.new({ MapRolePolicies: data })
    end
  end
end
