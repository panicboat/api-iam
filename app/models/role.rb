class Role < ApplicationRecord
  has_many :map_role_policies,  dependent:  :destroy
  has_many :policies,           through:    :map_role_policies

  has_many :map_group_roles,    dependent:  :destroy
  has_many :groups,             through:    :map_group_roles

  has_many :map_user_roles,     dependent:  :destroy
  has_many :users,              through:    :map_user_roles

  enum owner: { pnb: 1, user: 2 }
end
