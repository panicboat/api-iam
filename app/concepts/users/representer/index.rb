module Users::Representer
  class Index < Panicboat::Representer
    collection :Users, decorator: Show
  end
end
