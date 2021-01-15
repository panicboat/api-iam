module MapGroupUsers::Contract
  class Destroy < Abstract::Contract
    property  :group_id
    property  :user_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
    validates :user_id,   presence: true, format: { with: FORMAT_UUID }
  end
end
