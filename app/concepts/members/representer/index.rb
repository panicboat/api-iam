module Members::Representer
  class Index < Abstract::Representer
    collection :Members, decorator: Show
  end
end
