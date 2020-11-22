module MapUserPolicies::Representer
  class Index < Abstract::Representer
    collection :MapUserPolicies, decorator: Show
  end
end
