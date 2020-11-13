class MapUserPoliciesController < ApplicationController
  def index
    run MapUserPolicies::Operation::Index, params: params do |ctx|
      render json: represent(MapUserPolicies::Representer::Index, ctx)
    end
  end

  def create
    run MapUserPolicies::Operation::Create, params: params do |ctx|
      render json: represent(MapUserPolicies::Representer::Show, ctx)
    end
  end

  def destroy
    run MapUserPolicies::Operation::Destroy, params: params do |ctx|
      render json: represent(MapUserPolicies::Representer::Show, ctx)
    end
  end
end
