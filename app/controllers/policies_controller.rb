class PoliciesController < ApplicationController
  def index
    run Policies::Operation::Index, params: params do |ctx|
      render json: represent(Policies::Representer::Index, ctx)
    end
  end

  def show
    run Policies::Operation::Show, params: params do |ctx|
      render json: represent(Policies::Representer::Show, ctx)
    end
  end

  def create
    run Policies::Operation::Create, params: params do |ctx|
      render json: represent(Policies::Representer::Create, ctx)
    end
  end

  def update
    run Policies::Operation::Update, params: params do |ctx|
      render json: represent(Policies::Representer::Update, ctx)
    end
  end

  def destroy
    run Policies::Operation::Destroy, params: params do |ctx|
      render json: represent(Policies::Representer::Destroy, ctx)
    end
  end
end
