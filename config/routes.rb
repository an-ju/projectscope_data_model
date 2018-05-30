Rails.application.routes.draw do
  resources :users
  resources :activities
  resources :projects do
    member do
      post :events, to: 'projects#create_events'
      get :events, to: 'projects#events'
    end
  end
  resources :configurations
  resources :resources
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
