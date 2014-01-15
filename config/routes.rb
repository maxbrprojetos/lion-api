Notdvs::Application.routes.draw do
  namespace :api do
    resources :notices
    resources :users do
      collection do
        get :me
      end
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'
end
