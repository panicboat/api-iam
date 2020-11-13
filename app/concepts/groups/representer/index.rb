module Groups::Representer
  class Index < Abstract::Representer
    collection :Groups, decorator: Show
  end
end
