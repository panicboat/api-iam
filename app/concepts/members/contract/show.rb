module Members::Contract
  class Show < Abstract::Contract
    property  :id

    validates :id, presence: true, format: { with: FORMAT_UUID }
  end
end
