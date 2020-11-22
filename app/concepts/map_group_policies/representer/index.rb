module MapGroupPolicies::Representer
  class Index < Abstract::Representer
    collection :MapGroupPolicies, decorator: Show
  end
end
