module MapGroupPolicies::Contract
  class Create < Abstract::Contract
    property  :group_id
    property  :policy_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      errors.add(:policy_id, I18n.t('errors.messages.taken')) if ::MapGroupPolicy.where({ group_id: group_id, policy_id: policy_id }).present?
    end
  end
end
