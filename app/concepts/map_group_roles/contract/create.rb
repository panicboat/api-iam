module MapGroupRoles::Contract
  class Create < Abstract::Contract
    property  :group_id
    property  :role_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :role_id,   presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :role_id, scope: [:group_id]
      errors.add(:role_id, I18n.t('errors.messages.taken')) if ::MapGroupRole.where({ group_id: group_id, role_id: role_id }).present?
    end
  end
end
