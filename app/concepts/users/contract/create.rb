module Users::Contract
  class Create < Abstract::Contract
    property  :email
    property  :name

    validates :email, presence: true, format: { with: FORMAT_EMAIL }
    validates :name,  presence: true
    validate  :uniqueness

    def uniqueness
      errors.add(:email, I18n.t('errors.messages.taken')) if ::User.where.not({ id: id }).where({ email: email }).present?
    end
  end
end
