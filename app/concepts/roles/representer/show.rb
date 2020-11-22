module Roles::Representer
  class Show < Panicboat::Representer
    property :id
    property :name
    property :description
    property :owner
    property :created_at
    property :updated_at
  end
end
