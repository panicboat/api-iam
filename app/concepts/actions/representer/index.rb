module Actions::Representer
  class Index < Abstract::Representer
    collection :Actions, decorator: Show
  end
end
