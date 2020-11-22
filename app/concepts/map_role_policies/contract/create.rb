module MapRolePolicies::Contract
  class Create < Panicboat::Contract
    property  :role_id
    property  :policy_id

    validates :role_id,   presence: true, format: { with: FORMAT_UUID }
    validates :policy_id, presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :policy_id, scope: [:role_id]
      errors.add(:policy_id, I18n.t('errors.messages.taken')) if ::MapRolePolicy.where({ role_id: role_id, policy_id: policy_id }).present?
    end
  end
end
