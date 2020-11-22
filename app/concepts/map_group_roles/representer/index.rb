module MapGroupRoles::Representer
  class Index < Abstract::Representer
    collection :MapGroupRoles, decorator: Show
  end
end
