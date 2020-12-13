class UsersController < ApplicationController
  def index
    run Users::Operation::Index, params: params do |ctx|
      render json: represent(Users::Representer::Index, ctx)
    end
  end

  def show
    run Users::Operation::Show, params: params do |ctx|
      render json: represent(Users::Representer::Show, ctx)
    end
  end

  def create
    run Users::Operation::Create, params: params do |ctx|
      render json: represent(Users::Representer::Create, ctx)
    end
  end

  def update
    run Users::Operation::Update, params: params do |ctx|
      render json: represent(Users::Representer::Update, ctx)
    end
  end

  def destroy
    run Users::Operation::Destroy, params: params do |ctx|
      render json: represent(Users::Representer::Destroy, ctx)
    end
  end
end
