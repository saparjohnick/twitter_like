Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_in', to: 'users/sessions#new'
    get 'users/:id', to: 'users#show', :as => 'user_profile'
    delete 'users/:id', to: 'users#destroy', :as => 'user_destroy'
    get 'users' => 'users#index'
  end

  post 'microposts' => 'microposts#create'
  delete 'microposts/:id' => 'microposts#destroy', :as => 'micropost_destroy'

  # resources :users, only: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
