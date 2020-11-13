module MapGroupRoles::Contract
  class Destroy < Abstract::Contract
    property  :group_id
    property  :role_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :role_id,   presence: true, format: { with: FORMAT_UUID }
    validate  :exists

    def exists
      errors.add(:group_role, I18n.t('errors.messages.invalid')) if ::MapGroupRole.where({ group_id: group_id, role_id: role_id }).blank?
    end
  end
end
