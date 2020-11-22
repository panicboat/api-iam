module Actions::Representer
  class Index < Panicboat::Representer
    collection :Actions, decorator: Show
  end
end
