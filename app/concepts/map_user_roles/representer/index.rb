module MapUserRoles::Representer
  class Index < Panicboat::Representer
    collection :MapUserRoles, decorator: Show
  end
end
