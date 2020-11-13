class Policy < ApplicationRecord
  has_many :statement,          dependent:  :destroy

  has_many :map_role_policies,  dependent:  :destroy
  has_many :roles,              through:    :map_role_policies

  has_many :map_group_policies, dependent:  :destroy
  has_many :groups,             through:    :map_group_policies

  has_many :map_user_policies,  dependent:  :destroy
  has_many :users,              through:    :map_user_policies

  enum owner: { pnb: 1, user: 2 }
end
