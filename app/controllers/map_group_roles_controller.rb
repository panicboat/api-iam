class MapGroupRolesController < ApplicationController
  def index
    run MapGroupRoles::Operation::Index, params: params do |ctx|
      render json: represent(MapGroupRoles::Representer::Index, ctx)
    end
  end

  def create
    run MapGroupRoles::Operation::Create, params: params do |ctx|
      render json: represent(MapGroupRoles::Representer::Create, ctx)
    end
  end

  def destroy
    run MapGroupRoles::Operation::Destroy, params: params do |ctx|
      render json: represent(MapGroupRoles::Representer::Destroy, ctx)
    end
  end
end
