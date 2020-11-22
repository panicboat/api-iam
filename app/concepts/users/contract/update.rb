module Users::Contract
  class Update < Panicboat::Contract
    property  :id
    property  :name

    validates :id,    presence: true, format: { with: FORMAT_UUID }
    validates :name,  presence: true
  end
end
