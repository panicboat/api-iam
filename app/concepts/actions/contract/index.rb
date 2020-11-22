module Actions::Contract
  class Index < Abstract::Contract
    property  :service_id

    validates :service_id, presence: true, format: { with: FORMAT_UUID }
  end
end
