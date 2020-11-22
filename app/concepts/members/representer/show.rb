module Members::Representer
  class Show < Panicboat::Representer
    property :id
    property :email
    property :name
    property :image
    property :description
    property :created_at
    property :updated_at
  end
end
