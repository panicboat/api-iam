Rails.application.routes.draw do
  mount Panicboat::Engine, at: '/panicboat'

  resources :health,        only: %i[index]
  resources :services,      only: %i[index show create update destroy] do
    resources :actions,     only: %i[index show create update destroy]
  end
  resources :roles,         only: %i[index show create update destroy] do
    resources :policies,    only: %i[index create destroy], param: :policy_id,      controller: 'map_role_policies'
  end
  resources :policies,      only: %i[index show create update destroy]

  resources :groups,        only: %i[index show create update destroy] do
    resources :users,       only: %i[index create destroy], param: :user_id,        controller: 'map_group_users'
    resources :roles,       only: %i[index create destroy], param: :role_id,        controller: 'map_group_roles'
    resources :policies,    only: %i[index create destroy], param: :policy_id,      controller: 'map_group_policies'
  end

  resources :users,         only: %i[index show create update destroy] do
    resources :roles,       only: %i[index create destroy], param: :role_id,        controller: 'map_user_roles'
    resources :policies,    only: %i[index create destroy], param: :policy_id,      controller: 'map_user_policies'
  end

  resources :tokens,        only: %i[index]
  resources :permissions,   only: %i[index show]
end
