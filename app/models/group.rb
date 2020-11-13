class Group < ApplicationRecord
  has_many :map_group_users,    dependent:  :destroy
  has_many :users,              through:    :map_group_users

  has_many :map_group_roles,    dependent:  :destroy
  has_many :roles,              through:    :map_group_roles

  has_many :map_group_policies, dependent:  :destroy
  has_many :policies,           through:    :map_group_policies
end
