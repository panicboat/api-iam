module MapUserPolicies::Contract
  class Create < Panicboat::Contract
    property  :user_id
    property  :policy_id

    validates :user_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :policy_id, scope: [:user_id]
      errors.add(:policy_id, I18n.t('errors.messages.taken')) if ::MapUserPolicy.where({ user_id: user_id, policy_id: policy_id }).present?
    end
  end
end
