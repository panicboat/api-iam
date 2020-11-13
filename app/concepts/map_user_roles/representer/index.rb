module MapUserRoles::Representer
  class Index < Abstract::Representer
    collection :MapUserRoles, decorator: Show
  end
end
