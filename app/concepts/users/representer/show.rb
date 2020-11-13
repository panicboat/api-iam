module Users::Representer
  class Show < Abstract::Representer
    property :id
    property :email
    property :name
    property :image
    property :created_at
    property :updated_at
  end
end
