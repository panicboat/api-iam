module Policies::Representer
  class Show < Abstract::Representer
    property :id
    property :name
    property :description
    property :inline
    property :owner
    collection :statements do
      property :effect
      collection :actions
      collection :resources
    end
    property :created_at
    property :updated_at
  end
end
