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
    get 'sign_up', to: 'devise/registrations#new'
  end

  get 'users/:id', to: 'users#show', :as => 'user_profile'

  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
