module Actions::Representer
  class Show < Panicboat::Representer
    property :id
    property :name
    property :service_id
    property :description
    property :access_level
    property :created_at
    property :updated_at
  end
end
