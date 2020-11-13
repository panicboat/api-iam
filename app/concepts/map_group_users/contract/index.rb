module MapGroupUsers::Contract
  class Index < Abstract::Contract
    property  :group_id

    validates :group_id,  presence: true, format: { with: FORMAT_UUID }
  end
end
