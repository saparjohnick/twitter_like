require 'sidekiq/web'
require 'sidekiq-scheduler/web'
# require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  mount Sidekiq::Web => '/sidekiq'

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_in', to: 'users/sessions#new'
    get 'users/:id', to: 'users#show', as: 'user_profile'
    delete 'users/:id', to: 'users#destroy', as: 'user_destroy'
    get 'users' => 'users#index'
  end

  post 'microposts' => 'microposts#create'
  delete 'microposts/:id' => 'microposts#destroy', :as => 'micropost_destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end
  # followers_user GET    /users/:id/followers(.:format)    users#followers
  # following_user GET    /users/:id/following(.:format)    users#following

  resources :relationships, only: %i[create destroy]
  # relationships POST   /relationships(.:format)          relationships#create
  # relationship DELETE /relationships/:id(.:format)      relationships#destroy

  # resources :users, only: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # REST API implementation
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/users/sessions',
        passwords: 'api/v1/users/passwords',
        registrations: 'api/v1/users/registrations'
      }, defaults: { format: :json }, as: :users
      resources :microposts, only: %i[index]
      resources :microposts_search, only: %i[index]
    end
  end
end
