class User < ApplicationRecord
  has_many :map_group_users,      dependent:  :destroy
  has_many :groups,               through:    :map_group_users

  has_many :map_user_roles,       dependent:  :destroy
  has_many :roles,                through:    :map_user_roles

  has_many :map_user_policies,    dependent:  :destroy
  has_many :policies,             through:    :map_user_policies
end
