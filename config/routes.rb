Notdvs::Application.routes.draw do
  namespace :api do
    resources :notices, only: [:index, :create, :destroy]
    resources :tasks, only: [:index, :create, :update, :destroy]

    resources :users do
      collection do
        get :me
      end
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'
end
