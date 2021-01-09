module Members::Contract
  class Update < Create
    property  :id

    validates :id, presence: true, format: { with: FORMAT_UUID }
  end
end
