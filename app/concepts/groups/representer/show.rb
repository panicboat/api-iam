module Groups::Representer
  class Show < Panicboat::Representer
    property :id
    property :name
    property :description
    property :created_at
    property :updated_at
  end
end
