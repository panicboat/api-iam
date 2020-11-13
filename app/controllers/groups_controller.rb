class GroupsController < ApplicationController
  def index
    run Groups::Operation::Index, params: params do |ctx|
      render json: represent(Groups::Representer::Index, ctx)
    end
  end

  def show
    run Groups::Operation::Show, params: params do |ctx|
      render json: represent(Groups::Representer::Show, ctx)
    end
  end

  def create
    run Groups::Operation::Create, params: params do |ctx|
      render json: represent(Groups::Representer::Show, ctx)
    end
  end

  def update
    run Groups::Operation::Update, params: params do |ctx|
      render json: represent(Groups::Representer::Show, ctx)
    end
  end

  def destroy
    run Groups::Operation::Destroy, params: params do |ctx|
      render json: represent(Groups::Representer::Show, ctx)
    end
  end
end
