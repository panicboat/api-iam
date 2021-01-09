module Members::Contract
  class Create < Abstract::Contract
    property  :email
    property  :name
    property  :description

    validates :email,       presence: true, format: { with: FORMAT_EMAIL }
    validates :name,        presence: true
    validates :description, presence: false
    validate  :uniqueness

    def uniqueness
      errors.add(:email, I18n.t('errors.messages.taken')) if ::Member.where.not({ id: id }).where({ email: email }).present?
    end
  end
end
