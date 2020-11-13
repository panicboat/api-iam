class MapRolePoliciesController < ApplicationController
  def index
    run MapRolePolicies::Operation::Index, params: params do |ctx|
      render json: represent(MapRolePolicies::Representer::Index, ctx)
    end
  end

  def create
    run MapRolePolicies::Operation::Create, params: params do |ctx|
      render json: represent(MapRolePolicies::Representer::Show, ctx)
    end
  end

  def destroy
    run MapRolePolicies::Operation::Destroy, params: params do |ctx|
      render json: represent(MapRolePolicies::Representer::Show, ctx)
    end
  end
end
