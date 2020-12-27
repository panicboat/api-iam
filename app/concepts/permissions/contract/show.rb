module Permissions::Contract
  class Show < Abstract::Contract
    property  :id
    property  :service_action_name

    validates :id, presence: true
    validate  :validate_action

    def validate_action
      model = if service_action_name.present?
                ::Action.joins(:service).where('CONCAT(`services`.`name`, ":", `actions`.`name`) = ?', service_action_name)
              else
                ::Action.joins(:service).find_by(id: id)
              end
      errors.add(:service_action_name, I18n.t('errors.messages.invalid')) if model.blank?
    end
  end
end
