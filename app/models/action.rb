class Action < ApplicationRecord
  belongs_to :service

  enum access_level: { list: 1, read: 2, write: 3 }
end
