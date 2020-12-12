module Roles::Operation
  class Index < Abstract::Operation
    step Model(::Role)
    step Contract::Build(constant: Roles::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::Role.paging(contract.limit, contract.offset).order(contract.order)
      ctx[:model] = OpenStruct.new({ Roles: data })
    end
  end
end
