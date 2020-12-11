class TokensController < ApplicationController
  def index
    run Tokens::Operation::Index, params: params do |ctx|
      render json: represent(Tokens::Representer::Index, ctx)
    end
  end
end
