class Abstract::Operation < Panicboat::Operation
  def permit!(ctx, **)
    raise NotImplementedError
  end
end
