module MapGroupUsers::Contract
  class Destroy < Abstract::Contract
    property  :group_id
    property  :user_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :user_id,   presence: true, format: { with: FORMAT_UUID }
    validate  :exists

    def exists
      errors.add(:group_user, I18n.t('errors.messages.invalid')) if ::MapGroupUser.where({ group_id: group_id, user_id: user_id }).blank?
    end
  end
end
