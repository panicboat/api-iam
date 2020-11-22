module MapRolePolicies::Representer
  class Show < Abstract::Representer
    property  :id
    property  :role_id
    property  :policy_id
    property  :created_at
    property  :updated_at
  end
end
