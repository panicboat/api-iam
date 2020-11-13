module Policies::Operation::Concerns
  class Refresh
    def initialize(statements)
      @statements = statements
    end

    def save!(model)
      statements.each do |statement|
        st = ::Statement.create!({ id: ::Identity.uuid(::Statement), policy_id: model.id, effect: ::Statement.effects[statement.effect.to_sym] })
        resources(st, statement.resources)
        actions(st, statement.actions)
      end
    end

    private

    attr_accessor :statements

    def resources(model, resources)
      resources.each do |resource|
        ::Resource.create!({ statement_id: model.id, name: resource })
      end
    end

    def actions(model, actions)
      actions.each do |name|
        ::MapStatementAction.create!({ statement_id: model.id, action: name })
      end
    end
  end
end
