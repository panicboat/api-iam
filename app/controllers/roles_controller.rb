class RolesController < ApplicationController
  def index
    run Roles::Operation::Index, params: params do |ctx|
      render json: represent(Roles::Representer::Index, ctx)
    end
  end

  def show
    run Roles::Operation::Show, params: params do |ctx|
      render json: represent(Roles::Representer::Show, ctx)
    end
  end

  def create
    run Roles::Operation::Create, params: params do |ctx|
      render json: represent(Roles::Representer::Create, ctx)
    end
  end

  def update
    run Roles::Operation::Update, params: params do |ctx|
      render json: represent(Roles::Representer::Update, ctx)
    end
  end

  def destroy
    run Roles::Operation::Destroy, params: params do |ctx|
      render json: represent(Roles::Representer::Destroy, ctx)
    end
  end
end
