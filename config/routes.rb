Notdvs::Application.routes.draw do
  namespace :api do
    resources :notices
  end

  root 'home#index'
end
