module Actions::Operation
  class Index < Abstract::Operation
    step Model(::Action)
    step Contract::Build(constant: Actions::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = scrape(ctx).paging(contract.limit, contract.offset).order(contract.order)
      data = data.where({ service_id: contract.service_id }) if contract.service_id.present?
      data = data.where({ name: contract.name }) if contract.name.present?
      ctx[:model] = OpenStruct.new({ Actions: data })
    end
  end
end
