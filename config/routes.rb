Rails.application.routes.draw do
  root 'static_pages#top'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure',           to: 'sessions#auth_failure'

  resources :users do
    resources :plans do
      resources :checklists, only: :destroy
      member do
        patch :check
      end
    end
  end
end