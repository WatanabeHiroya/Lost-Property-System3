Rails.application.routes.draw do
  root 'static_pages#top'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  resources :users do
    resources :plans do
      member do
        patch :check
      end
    end
  end
end
