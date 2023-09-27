Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#login'
      resources :users, param: :_username
      end
    end

  get '/*a', to: 'application#not_found'
end