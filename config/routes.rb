Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#login'
      resources :users, param: :_username
      resources :libraries do
        resources :categories do
          resources :books
        end
      end
      end
    end

  resources '/*a', to: 'application#not_found'
end