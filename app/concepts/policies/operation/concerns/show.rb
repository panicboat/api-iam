module Policies::Operation::Concerns
  class Show
    def initialize(policy)
      @policy = policy
    end

    def model
      model = OpenStruct.new(policy.attributes)
      model.statements = []
      ::Statement.where({ policy_id: policy.id }).each do |statement|
        model.statements.push(statement(statement))
      end
      model
    end

    private

    attr_accessor :policy

    def statement(statement)
      st = OpenStruct.new(statement.attributes)
      st.actions = actions(statement)
      st.resources = resources(statement)
      st
    end

    def actions(statement)
      actions = []
      ::MapStatementAction.where({ statement_id: statement.id }).find_each do |map_statement_action|
        actions.push(map_statement_action.action)
      end
      actions
    end

    def resources(statement)
      resources = []
      ::Resource.where({ statement_id: statement.id }).find_each do |resource|
        resources.push(resource.name)
      end
      resources
    end
  end
end
