module MapRolePolicies::Contract
  class Index < Panicboat::Contract
    property  :role_id

    validates :role_id, presence: true, format: { with: FORMAT_UUID }
  end
end
