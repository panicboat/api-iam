module MapGroupPolicies::Contract
  class Destroy < Abstract::Contract
    property  :group_id
    property  :policy_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :exists

    def exists
      errors.add(:group_policy, I18n.t('errors.messages.invalid')) if ::MapGroupPolicy.where({ group_id: group_id, policy_id: policy_id }).blank?
    end
  end
end
