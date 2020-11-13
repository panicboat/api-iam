class Statement < ApplicationRecord
  belongs_to :policy

  has_many :resources,              dependent:  :destroy

  has_many :map_statement_actions,  dependent:  :destroy

  enum effect: { allow: 1, deny: 2 }
end
