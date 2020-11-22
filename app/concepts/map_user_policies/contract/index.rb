module MapUserPolicies::Contract
  class Index < Panicboat::Contract
    property  :user_id

    validates :user_id, presence: true, format: { with: FORMAT_UUID }
  end
end
