module Roles::Representer
  class Index < Panicboat::Representer
    collection :Roles, decorator: Show
  end
end
