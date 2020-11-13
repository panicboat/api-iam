module Members::Contract
  class Destroy < Abstract::Contract
    property  :id

    validates :id, presence: true, format: { with: FORMAT_UUID }
  end
end
