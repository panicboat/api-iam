class MapGroupUsersController < ApplicationController
  def index
    run MapGroupUsers::Operation::Index, params: params do |ctx|
      render json: represent(MapGroupUsers::Representer::Index, ctx)
    end
  end

  def create
    run MapGroupUsers::Operation::Create, params: params do |ctx|
      render json: represent(MapGroupUsers::Representer::Show, ctx)
    end
  end

  def destroy
    run MapGroupUsers::Operation::Destroy, params: params do |ctx|
      render json: represent(MapGroupUsers::Representer::Show, ctx)
    end
  end
end
