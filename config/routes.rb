Rails.application.routes.draw do
    resources :users, only: [:new, :create, :show] do
      resources :projects, only: [:new, :show, :create] 
      get "projects", to: 'projects#projects', as: 'projects_profile'
    end 
    get "create_project", to: 'users#createproject'

    resources :features
    get "/view", to: 'features#view', as: 'view'
    resources :finds
    
    
    get "", to: 'sessions#index'
    get "/welcome", to: 'sessions#welcome'
    post "/login", to:'sessions#create'
    get "/login", to: 'sessions#new'
    get "authorized", to: 'sessions#page_requires_login'
    delete "/welcome", to: 'sessions#destroy'

    
    
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
