module Groups::Representer
  class Index < Panicboat::Representer
    collection :Groups, decorator: Show
  end
end
