require 'sidekiq/web'
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
        sessions: 'users/sessions',
        passwords: 'users/passwords',
        registrations: 'users/registrations'
      }
      resources :users do
        member do
          get :microposts, only: %i[index]
        end
      end
    end
  end
end
# new_api_v1_user_session GET    /api/v1/users/sign_in(.:format)          users/sessions#new {:format=>"json"}
# api_v1_user_session POST   /api/v1/users/sign_in(.:format)          users/sessions#create {:format=>"json"}
# destroy_api_v1_user_session DELETE /api/v1/users/sign_out(.:format)         users/sessions#destroy {:format=>"json"}
# new_api_v1_user_password GET    /api/v1/users/password/new(.:format)     users/passwords#new {:format=>"json"}
# edit_api_v1_user_password GET    /api/v1/users/password/edit(.:format)    users/passwords#edit {:format=>"json"}
# api_v1_user_password PATCH  /api/v1/users/password(.:format)         users/passwords#update {:format=>"json"}
#                     PUT    /api/v1/users/password(.:format)         users/passwords#update {:format=>"json"}
#                     POST   /api/v1/users/password(.:format)         users/passwords#create {:format=>"json"}
# cancel_api_v1_user_registration GET    /api/v1/users/cancel(.:format)           users/registrations#cancel {:format=>"json"}
# new_api_v1_user_registration GET    /api/v1/users/sign_up(.:format)          users/registrations#new {:format=>"json"}
# edit_api_v1_user_registration GET    /api/v1/users/edit(.:format)             users/registrations#edit {:format=>"json"}
# api_v1_user_registration PATCH  /api/v1/users(.:format)                  users/registrations#update {:format=>"json"}
#                     PUT    /api/v1/users(.:format)                  users/registrations#update {:format=>"json"}
#                     DELETE /api/v1/users(.:format)                  users/registrations#destroy {:format=>"json"}
#                     POST   /api/v1/users(.:format)                  users/registrations#create {:format=>"json"}
# new_api_v1_user_confirmation GET    /api/v1/users/confirmation/new(.:format) api/v1/confirmations#new {:format=>"json"}
# api_v1_user_confirmation GET    /api/v1/users/confirmation(.:format)     api/v1/confirmations#show {:format=>"json"}
#                     POST   /api/v1/users/confirmation(.:format)     api/v1/confirmations#create {:format=>"json"}
# microposts_api_v1_user GET    /api/v1/users/:id/microposts(.:format)   api/v1/users#microposts {:format=>"json", :only=>[:index]}
#        api_v1_users GET    /api/v1/users(.:format)                  api/v1/users#index {:format=>"json"}
#                     POST   /api/v1/users(.:format)                  api/v1/users#create {:format=>"json"}
#     new_api_v1_user GET    /api/v1/users/new(.:format)              api/v1/users#new {:format=>"json"}
#    edit_api_v1_user GET    /api/v1/users/:id/edit(.:format)         api/v1/users#edit {:format=>"json"}
#         api_v1_user GET    /api/v1/users/:id(.:format)              api/v1/users#show {:format=>"json"}
#                     PATCH  /api/v1/users/:id(.:format)              api/v1/users#update {:format=>"json"}
#                     PUT    /api/v1/users/:id(.:format)              api/v1/users#update {:format=>"json"}
#                     DELETE /api/v1/users/:id(.:format)              api/v1/users#destroy {:format=>"json"}
