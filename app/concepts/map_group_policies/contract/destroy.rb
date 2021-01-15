module MapGroupPolicies::Contract
  class Destroy < Abstract::Contract
    property  :group_id
    property  :policy_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
  end
end
