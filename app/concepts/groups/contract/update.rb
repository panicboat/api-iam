module Groups::Contract
  class Update < Panicboat::Contract
    property  :id
    property  :name
    property  :description

    validates :id,          presence: true, format: { with: FORMAT_UUID }
    validates :name,        presence: true
    validates :description, presence: false
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :name
      errors.add(:name, I18n.t('errors.messages.taken')) if ::Group.where.not({ id: id }).where({ name: name }).present?
    end
  end
end
