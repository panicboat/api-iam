class Abstract::Operation < Panicboat::Operation
  def permit!(ctx, **)
    Rails.logger.info ctx[:action]
  end
end
