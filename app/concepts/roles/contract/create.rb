module Roles::Contract
  class Create < Abstract::Contract
    property  :name
    property  :description
    property  :owner,       default: 'user'

    validates :name,        presence: true
    validates :description, presence: false
    validates :owner,       presence: false, inclusion: { in: ::Role.owners.keys }
    validate  :uniqueness

    def uniqueness
      errors.add(:name, I18n.t('errors.messages.taken')) if ::Role.where.not({ id: id }).where({ name: name }).present?
    end
  end
end
