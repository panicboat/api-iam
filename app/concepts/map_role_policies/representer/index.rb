module MapRolePolicies::Representer
  class Index < Abstract::Representer
    collection :MapRolePolicies, decorator: Show
  end
end
