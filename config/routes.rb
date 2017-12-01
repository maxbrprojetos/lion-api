Lion::Application.routes.draw do
  namespace :api do
    resources :pull_requests, only: :create
    post '/auth', to: 'auth#execute'
    post '/graph', to: 'graph#execute'
  end

  get '*a', to: 'home#index'

  root 'home#index'
end
