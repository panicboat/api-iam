module MapUserPolicies::Representer
  class Show < Abstract::Representer
    property  :id
    property  :user_id
    property  :policy_id
    property  :created_at
    property  :updated_at
  end
end
