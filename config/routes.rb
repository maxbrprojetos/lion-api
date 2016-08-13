require 'sidekiq/web'

Lion::Application.routes.draw do
  namespace :api do
    resources :users do
      collection do
        get :me
      end
    end

    resources :pull_requests, only: :create
    resources :scores, only: :index
    resources :weekly_winnings, only: :index
    resources :stats, only: :index
    resources :tokens, only: :create
    post '/auth', to: 'auth#execute'
    post '/graph', to: 'graph#execute'
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end if Rails.env.production?

  mount Sidekiq::Web, at: '/sidekiq'

  get '*a', to: 'home#index'

  root 'home#index'
end
