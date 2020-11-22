module Members::Representer
  class Index < Panicboat::Representer
    collection :Members, decorator: Show
  end
end
