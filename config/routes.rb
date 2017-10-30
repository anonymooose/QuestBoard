Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :events do
    resources :surveys, only: [ :show, :update ]
    resources :players, only: [ :create, :destroy, :edit, :update ]
  end
  get 'surveys', to: 'surveys#index'
  resources :avatars, only: [ :edit, :update ]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
