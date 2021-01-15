module MapRolePolicies::Contract
  class Destroy < Abstract::Contract
    property  :role_id
    property  :policy_id

    validates :role_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
  end
end
