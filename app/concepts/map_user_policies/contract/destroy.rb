module MapUserPolicies::Contract
  class Destroy < Abstract::Contract
    property  :user_id
    property  :policy_id

    validates :user_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
  end
end
