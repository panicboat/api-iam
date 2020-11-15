module Permissions::Operation
  class Show < Abstract::Operation
    step Model(::OpenStruct)
    step Contract::Build(constant: Permissions::Contract::Show)
    step Contract::Validate()
    fail :invalid_params!
    step :model

    def model(ctx, **)
      contract = contract(ctx)
      data = []
      policies = Concerns::Show.new(contract(ctx[:current_user]).model).all
      ::Statement.joins(:policy).where({ policies: { id: policies.pluck(:id) } }).each do |statement|
        ::MapStatementAction.where({ statement_id: statement.id }).find_each do |map_statement_action|
          data.push(actions(contract.id, statement, map_statement_action))
        end
      end
      ctx[:model] = OpenStruct.new({ Permissions: data.flatten })
    end

    private

    def actions(id, statement, map_statement_action)
      data = []
      service_action_column = 'CONCAT(`services`.`name`, ":", `actions`.`name`)'
      name = map_statement_action.action.gsub(/\*/, '%')
      if ::Action.joins(:service).where("#{service_action_column} = ?", id).where("#{service_action_column} LIKE ?", name).present?
        resources = ::Resource.joins(:statement).where({ statements: { id: statement.id } }).pluck(:name)
        data.push(OpenStruct.new({ effect: statement.effect, prn: resources.present? ? resources : ['*'] }))
      end
      data
    end
  end
end
