module MapGroupUsers::Representer
  class Index < Panicboat::Representer
    collection :MapGroupUsers, decorator: Show
  end
end
