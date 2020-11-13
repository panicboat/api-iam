module Users::Representer
  class Index < Abstract::Representer
    collection :Users, decorator: Show
  end
end
