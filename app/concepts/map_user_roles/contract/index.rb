module MapUserRoles::Contract
  class Index < Abstract::Contract
    property  :user_id

    validates :user_id, presence: true, format: { with: FORMAT_UUID }
  end
end
