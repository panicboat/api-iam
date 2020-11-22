module Policies::Contract
  class Update < Panicboat::Contract
    property  :id
    property  :name
    property  :description
    property  :inline
    property  :owner

    validates :id,          presence: true, format: { with: FORMAT_UUID }
    validates :name,        presence: true
    validates :description, presence: false
    validates :inline,      presence: false, inclusion: { in: [true, false] }
    validates :owner,       presence: false, inclusion: { in: ::Policy.owners.keys }

    collection :statements, virtual: true, populate_if_empty: OpenStruct do
      property    :sid, virtual: true
      property    :effect
      collection  :actions,           virtual: true
      collection  :resources,         virtual: true

      validates   :effect,            presence: true, inclusion: { in: ::Statement.effects.keys }
    end
  end
end
