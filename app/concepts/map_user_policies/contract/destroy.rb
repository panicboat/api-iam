module MapUserPolicies::Contract
  class Destroy < Abstract::Contract
    property  :user_id
    property  :policy_id

    validates :user_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :exists

    def exists
      errors.add(:user_policy, I18n.t('errors.messages.invalid')) if ::MapUserPolicy.where({ user_id: user_id, policy_id: policy_id }).blank?
    end
  end
end
