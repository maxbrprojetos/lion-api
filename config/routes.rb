Notdvs::Application.routes.draw do
  namespace :api do
    resources :notices
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'
end
