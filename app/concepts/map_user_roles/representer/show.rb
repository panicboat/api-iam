module MapUserRoles::Representer
  class Show < Abstract::Representer
    property  :id
    property  :user_id
    property  :role_id
    property  :created_at
    property  :updated_at
  end
end
