module MapUserRoles::Contract
  class Destroy < Abstract::Contract
    property  :user_id
    property  :role_id

    validates :user_id, presence: true, format: { with: FORMAT_UUID }
    validates :role_id, presence: true, format: { with: FORMAT_UUID }
    validate  :exists

    def exists
      errors.add(:user_role, I18n.t('errors.messages.invalid')) if ::MapUserRole.where({ user_id: user_id, role_id: role_id }).blank?
    end
  end
end
