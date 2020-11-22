module Permissions::Contract
  class Show < Panicboat::Contract
    property  :id

    validates :id, presence: true
    validate  :validate_action

    def validate_action
      action = ::Action.joins(:service).where('CONCAT(`services`.`name`, ":", `actions`.`name`) = ?', id)
      errors.add(:id, I18n.t('errors.messages.invalid')) if action.blank?
    end
  end
end
