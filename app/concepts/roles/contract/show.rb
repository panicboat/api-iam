module Roles::Contract
  class Show < Panicboat::Contract
    property  :id

    validates :id, presence: true, format: { with: FORMAT_UUID }
  end
end
