Lion::Application.routes.draw do
  mount ActionCable.server => '/cable' # Serve websocket requests

  namespace :api do
    resources :pull_requests, only: :create
    post '/auth', to: 'auth#execute'
    post '/graph', to: 'graph#execute'
  end

  get '*a', to: 'home#index'

  root 'home#index'
end
