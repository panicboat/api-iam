module Services::Representer
  class Index < Abstract::Representer
    collection :Services, decorator: Show
  end
end
