module MapRolePolicies::Representer
  class Index < Panicboat::Representer
    collection :MapRolePolicies, decorator: Show
  end
end
