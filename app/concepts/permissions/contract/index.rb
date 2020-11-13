module Permissions::Contract
  class Index < Abstract::Contract
    property  :effect, default: 'allow'

    validates :effect, presence: false, inclusion: { in: ::Statement.effects.keys }
  end
end
