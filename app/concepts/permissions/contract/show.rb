module Permissions::Contract
  class Show < Abstract::Contract
    property  :id

    validates :id, presence: true
  end
end
