module Policies::Operation
  class Index < Abstract::Operation
    step Model(::Policy)
    step Contract::Build(constant: Policies::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = ::Policy.where({ inline: false }).paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Policies: data })
    end
  end
end
