module MapGroupUsers::Representer
  class Index < Abstract::Representer
    collection :MapGroupUsers, decorator: Show
  end
end
