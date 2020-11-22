module Roles::Contract
  class Create < Panicboat::Contract
    property  :name
    property  :description
    property  :owner,       default: 'user'

    validates :name,        presence: true
    validates :description, presence: false
    validates :owner,       presence: false, inclusion: { in: ::Role.owners.keys }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :name
      errors.add(:name, I18n.t('errors.messages.taken')) if ::Role.where({ name: name }).present?
    end
  end
end
