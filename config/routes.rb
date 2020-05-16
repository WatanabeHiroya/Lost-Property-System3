Rails.application.routes.draw do
  root 'static_pages#top'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  
  resources :users do
    member do
      resources :checklists
    end
  end
end
