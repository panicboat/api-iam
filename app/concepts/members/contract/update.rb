module Members::Contract
  class Update < Panicboat::Contract
    property  :id
    property  :name
    property  :description

    validates :id,          presence: true, format: { with: FORMAT_UUID }
    validates :name,        presence: true
    validates :description, presence: false
  end
end
