class MapGroupPoliciesController < ApplicationController
  def index
    run MapGroupPolicies::Operation::Index, params: params do |ctx|
      render json: represent(MapGroupPolicies::Representer::Index, ctx)
    end
  end

  def create
    run MapGroupPolicies::Operation::Create, params: params do |ctx|
      render json: represent(MapGroupPolicies::Representer::Show, ctx)
    end
  end

  def destroy
    run MapGroupPolicies::Operation::Destroy, params: params do |ctx|
      render json: represent(MapGroupPolicies::Representer::Show, ctx)
    end
  end
end
