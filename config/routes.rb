Rails.application.routes.draw do
  root 'static_pages#top'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure',           to: 'sessions#auth_failure'
  post :line_events, to: 'line_events#recieve'

  resources :users do
    resources :plans do
      member do
        patch :check
      end
    end
  end
end
