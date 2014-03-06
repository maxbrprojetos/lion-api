Notdvs::Application.routes.draw do
  namespace :api do
    resources :notices, only: [:index, :create, :destroy]
    resources :tasks, only: [:index, :create, :update, :destroy]

    resources :users do
      collection do
        get :me
      end
    end

    resources :task_completions, only: :create do
      collection do
        delete :destroy
      end
    end

    resources :pull_request_mergers, only: :create
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '*', to: 'home#index'

  root 'home#index'
end
