module MapGroupUsers::Operation
  class Destroy < Abstract::Operation
    step Model(::MapGroupUser)
    step Contract::Build(constant: MapGroupUsers::Contract::Destroy)
    step Contract::Validate()
    fail :invalid_params!
    step :permit!
    step :scrape!
    step :model!

    def model!(ctx, **)
      contract = ctx[:"contract.default"]
      data = ::MapGroupUser.find_by({ group_id: contract.group_id, user_id: contract.user_id })
      data.destroy
      ctx[:model] = data
    end
  end
end
