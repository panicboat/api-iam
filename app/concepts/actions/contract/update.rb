module Actions::Contract
  class Update < Abstract::Contract
    property  :id
    property  :service_id
    property  :name
    property  :description
    property  :access_level

    validates :id,            presence: true, format: { with: FORMAT_UUID }
    validates :service_id,    presence: true, format: { with: FORMAT_UUID }
    validates :name,          presence: true
    validates :description,   presence: false
    validates :access_level,  presence: true, inclusion: { in: ::Action.access_levels.keys }
    validate  :uniqueness

    def uniqueness
      # validates_uniqueness_of :name, scope: [:service_id]
      errors.add(:name, I18n.t('errors.messages.taken')) if ::Action.where.not({ id: id }).where({ service_id: service_id, name: name }).present?
    end
  end
end
