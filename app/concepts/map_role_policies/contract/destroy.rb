module MapRolePolicies::Contract
  class Destroy < Abstract::Contract
    property  :role_id
    property  :policy_id

    validates :role_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :exists

    def exists
      errors.add(:role_policy, I18n.t('errors.messages.invalid')) if ::MapRolePolicy.where({ role_id: role_id, policy_id: policy_id }).blank?
    end
  end
end
