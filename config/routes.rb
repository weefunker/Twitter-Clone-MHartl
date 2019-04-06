Rails.application.routes.draw do
  get 'password_resets/controller'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'


  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :edit, :create, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  get 'users/new'

  root 'static_pages#home'
  get     '/help',    to: 'static_pages#help'
  get     '/about',   to: 'static_pages#about'
  get     '/contact', to: 'static_pages#contact'
  get     '/signup',  to: 'users#new'
  post    '/signup',  to: 'users#create'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',   to: 'sessions#destroy'
  resources :users do 
    member do 
      get :following, :followers 
    end 
  end 
  
  

end
