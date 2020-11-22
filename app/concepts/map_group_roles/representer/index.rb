module MapGroupRoles::Representer
  class Index < Panicboat::Representer
    collection :MapGroupRoles, decorator: Show
  end
end
