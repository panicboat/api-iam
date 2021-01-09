module Groups::Contract
  class Create < Abstract::Contract
    property  :name
    property  :description

    validates :name,        presence: true
    validates :description, presence: false
    validate  :uniqueness

    def uniqueness
      errors.add(:name, I18n.t('errors.messages.taken')) if ::Group.where.not({ id: id }).where({ name: name }).present?
    end
  end
end
