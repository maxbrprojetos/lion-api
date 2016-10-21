require 'sidekiq/web'

Lion::Application.routes.draw do
  namespace :api do
    resources :pull_requests, only: :create
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
