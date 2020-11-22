module Permissions::Operation
  class Index < Abstract::Operation
    step Model(::OpenStruct)
    step Contract::Build(constant: Permissions::Contract::Index)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = []
      policies = Concerns::Show.new(ctx[:current_user].present? ? contract(ctx[:current_user]).model : nil).all
      statement_ids = ::Statement.joins(:policy).where({ policies: { id: policies.pluck(:id) }, effect: contract.effect }).pluck(:id)
      ::MapStatementAction.where({ statement_id: statement_ids }).find_each do |map_statement_action|
        data.push(actions(map_statement_action))
      end
      ctx[:model] = OpenStruct.new({ Permissions: data.flatten.uniq })
    end

    private

    def actions(map_statement_action)
      data = []
      name = map_statement_action.action.gsub(/\*/, '%')
      service_action_column = 'CONCAT(`services`.`name`, ":", `actions`.`name`)'
      ::Action.select("#{service_action_column} as name").joins(:service).where("#{service_action_column} LIKE ?", name).each do |action|
        data.push(action.name)
      end
      data
    end
  end
end
