module Policies::Contract
  class Create < Panicboat::Contract
    property  :name
    property  :description
    property  :inline,      default: false
    property  :owner,       default: 'user'

    validates :name,        presence: true
    validates :description, presence: false
    validates :inline,      presence: false, inclusion: { in: [true, false] }
    validates :owner,       presence: false, inclusion: { in: ::Policy.owners.keys }

    collection :statements, virtual: true, populate_if_empty: OpenStruct do
      property    :effect
      collection  :actions,           virtual: true
      collection  :resources,         virtual: true

      validates   :effect,            presence: true, inclusion: { in: ::Statement.effects.keys }
    end
  end
end
