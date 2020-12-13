class MapUserRolesController < ApplicationController
  def index
    run MapUserRoles::Operation::Index, params: params do |ctx|
      render json: represent(MapUserRoles::Representer::Index, ctx)
    end
  end

  def create
    run MapUserRoles::Operation::Create, params: params do |ctx|
      render json: represent(MapUserRoles::Representer::Create, ctx)
    end
  end

  def destroy
    run MapUserRoles::Operation::Destroy, params: params do |ctx|
      render json: represent(MapUserRoles::Representer::Destroy, ctx)
    end
  end
end
