class MapUserPolicy < ApplicationRecord
  belongs_to :user
  belongs_to :policy
end
