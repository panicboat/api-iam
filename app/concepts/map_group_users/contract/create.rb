module MapGroupUsers::Contract
  class Create < Panicboat::Contract
    property  :group_id
    property  :user_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :user_id,   presence: true, format: { with: FORMAT_UUID }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :user_id, scope: [:group_id]
      errors.add(:user_id, I18n.t('errors.messages.taken')) if ::MapGroupUser.where({ group_id: group_id, user_id: user_id }).present?
    end
  end
end
