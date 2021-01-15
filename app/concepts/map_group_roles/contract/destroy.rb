module MapGroupRoles::Contract
  class Destroy < Abstract::Contract
    property  :group_id
    property  :role_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :role_id,   presence: true, format: { with: FORMAT_UUID }
  end
end
