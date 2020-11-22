module Actions::Contract
  class Destroy < Panicboat::Contract
    property  :id
    property  :service_id

    validates :id,          presence: true, format: { with: FORMAT_UUID }
    validates :service_id,  presence: true, format: { with: FORMAT_UUID }
  end
end
