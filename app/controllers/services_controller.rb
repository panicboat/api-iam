class ServicesController < ApplicationController
  def index
    run Services::Operation::Index, params: params do |ctx|
      render json: represent(Services::Representer::Index, ctx)
    end
  end

  def show
    run Services::Operation::Show, params: params do |ctx|
      render json: represent(Services::Representer::Show, ctx)
    end
  end

  def create
    run Services::Operation::Create, params: params do |ctx|
      render json: represent(Services::Representer::Create, ctx)
    end
  end

  def update
    run Services::Operation::Update, params: params do |ctx|
      render json: represent(Services::Representer::Update, ctx)
    end
  end

  def destroy
    run Services::Operation::Destroy, params: params do |ctx|
      render json: represent(Services::Representer::Destroy, ctx)
    end
  end
end
