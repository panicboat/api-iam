module Services::Representer
  class Index < Panicboat::Representer
    collection :Services, decorator: Show
  end
end
