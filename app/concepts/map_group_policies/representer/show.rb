module MapGroupPolicies::Representer
  class Show < Panicboat::Representer
    property  :id
    property  :group_id
    property  :policy_id
    property  :created_at
    property  :updated_at
  end
end
