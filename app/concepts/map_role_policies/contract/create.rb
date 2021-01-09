module MapRolePolicies::Contract
  class Create < Abstract::Contract
    property  :role_id
    property  :policy_id

    validates :role_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      errors.add(:policy_id, I18n.t('errors.messages.taken')) if ::MapRolePolicy.where({ role_id: role_id, policy_id: policy_id }).present?
    end
  end
end
