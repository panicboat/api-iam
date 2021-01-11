module MapUserRoles::Contract
  class Destroy < Abstract::Contract
    property  :user_id
    property  :role_id

    validates :user_id, presence: true, format: { with: FORMAT_UUID }
    validates :role_id, presence: true, format: { with: FORMAT_UUID }
  end
end
