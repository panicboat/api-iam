module Roles::Representer
  class Index < Abstract::Representer
    collection :Roles, decorator: Show
  end
end
