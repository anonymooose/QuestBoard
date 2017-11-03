Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'history', to: 'users#history'
  end
  resources :events do
    resources :surveys, only: [ :show, :update ]
    resources :players, only: [ :create, :destroy, :edit, :update ]
  end
  get 'surveys', to: 'surveys#index'
  resources :avatars, only: [ :edit, :update ]
  resources :games, only: [ :index ] do
    get :autocomplete_game_name, :on => :collection
  end
  get 'about', to: 'pages#about'
end
