module MapUserRoles::Contract
  class Create < Panicboat::Contract
    property  :user_id
    property  :role_id

    validates :user_id, presence: true, format: { with: FORMAT_UUID }
    validates :role_id, presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :role_id, scope: [:user_id]
      errors.add(:role_id, I18n.t('errors.messages.taken')) if ::MapUserRole.where({ user_id: user_id, role_id: role_id }).present?
    end
  end
end
