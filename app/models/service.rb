class Service < ApplicationRecord
  has_many :actions, dependent: :destroy
end
