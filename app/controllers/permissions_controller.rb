class PermissionsController < ApplicationController
  def index
    run Permissions::Operation::Index, params: params do |ctx|
      render json: represent(Permissions::Representer::Index, ctx)
    end
  end

  def show
    run Permissions::Operation::Show, params: params do |ctx|
      render json: represent(Permissions::Representer::Show, ctx)
    end
  end
end
