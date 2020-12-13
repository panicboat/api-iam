class MembersController < ApplicationController
  def index
    run Members::Operation::Index, params: params do |ctx|
      render json: represent(Members::Representer::Index, ctx)
    end
  end

  def show
    run Members::Operation::Show, params: params do |ctx|
      render json: represent(Members::Representer::Show, ctx)
    end
  end

  def create
    run Members::Operation::Create, params: params do |ctx|
      render json: represent(Members::Representer::Create, ctx)
    end
  end

  def update
    run Members::Operation::Update, params: params do |ctx|
      render json: represent(Members::Representer::Update, ctx)
    end
  end

  def destroy
    run Members::Operation::Destroy, params: params do |ctx|
      render json: represent(Members::Representer::Destroy, ctx)
    end
  end
end
