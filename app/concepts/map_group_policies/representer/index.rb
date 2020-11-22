module MapGroupPolicies::Representer
  class Index < Panicboat::Representer
    collection :MapGroupPolicies, decorator: Show
  end
end
