module MapUserPolicies::Contract
  class Create < Abstract::Contract
    property  :user_id
    property  :policy_id

    validates :user_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      errors.add(:policy_id, I18n.t('errors.messages.taken')) if ::MapUserPolicy.where({ user_id: user_id, policy_id: policy_id }).present?
    end
  end
end
