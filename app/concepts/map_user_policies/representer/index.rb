module MapUserPolicies::Representer
  class Index < Panicboat::Representer
    collection :MapUserPolicies, decorator: Show
  end
end
