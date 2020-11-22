module Members::Contract
  class Create < Panicboat::Contract
    property  :email
    property  :name
    property  :description

    validates :email,       presence: true, format: { with: FORMAT_EMAIL }
    validates :name,        presence: true
    validates :description, presence: false
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :email
      errors.add(:email, I18n.t('errors.messages.taken')) if ::Member.where({ email: email }).present?
    end
  end
end
