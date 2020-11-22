module Users::Contract
  class Create < Panicboat::Contract
    property  :email
    property  :name

    validates :email, presence: true, format: { with: FORMAT_EMAIL }
    validates :name,  presence: true
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :email
      errors.add(:email, I18n.t('errors.messages.taken')) if ::User.where({ email: email }).present?
    end
  end
end
