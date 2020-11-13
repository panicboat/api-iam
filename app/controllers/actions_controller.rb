class ActionsController < ApplicationController
  def index
    run Actions::Operation::Index, params: params do |ctx|
      render json: represent(Actions::Representer::Index, ctx)
    end
  end

  def show
    run Actions::Operation::Show, params: params do |ctx|
      render json: represent(Actions::Representer::Show, ctx)
    end
  end

  def create
    run Actions::Operation::Create, params: params do |ctx|
      render json: represent(Actions::Representer::Show, ctx)
    end
  end

  def update
    run Actions::Operation::Update, params: params do |ctx|
      render json: represent(Actions::Representer::Show, ctx)
    end
  end

  def destroy
    run Actions::Operation::Destroy, params: params do |ctx|
      render json: represent(Actions::Representer::Show, ctx)
    end
  end
end
