module MapGroupPolicies::Contract
  class Create < Panicboat::Contract
    property  :group_id
    property  :policy_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :policy_id, scope: [:group_id]
      errors.add(:policy_id, I18n.t('errors.messages.taken')) if ::MapGroupPolicy.where({ group_id: group_id, policy_id: policy_id }).present?
    end
  end
end
