module Permissions::Operation
  class Show < Abstract::Operation
    step Model(::OpenStruct)
    step Contract::Build(constant: Permissions::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = ctx[:"contract.default"]
      data = []
      policies = Concerns::Show.new(ctx[:current_user]).all
      ::Statement.joins(:policy).where({ policies: { id: policies.pluck(:id) } }).each do |statement|
        ::MapStatementAction.where({ statement_id: statement.id }).find_each do |map_statement_action|
          data.push(actions(contract.id, contract.service_action_name, statement, map_statement_action))
        end
      end
      ctx[:model] = OpenStruct.new({ Permissions: data.flatten })
    end

    private

    def actions(id, service_action_name, statement, map_statement_action)
      data = []
      name = map_statement_action.action.gsub(/\*/, '%')
      service_action_column = 'CONCAT(`services`.`name`, ":", `actions`.`name`)'
      if action(id, service_action_name).where("#{service_action_column} LIKE ?", name).present?
        resources = ::Resource.joins(:statement).where({ statements: { id: statement.id } }).pluck(:name)
        data.push(OpenStruct.new({ effect: statement.effect, prn: resources.present? ? resources : ['*'] }))
      end
      data
    end

    def action(id, service_action_name)
      if service_action_name.present?
        service_action_column = 'CONCAT(`services`.`name`, ":", `actions`.`name`)'
        ::Action.joins(:service).where("#{service_action_column}  = ?", service_action_name)
      else
        ::Action.joins(:service).find_by(id: id)
      end
    end
  end
end
