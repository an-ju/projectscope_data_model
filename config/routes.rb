Rails.application.routes.draw do
  resources :users
  resources :activities
  resources :projects
  resources :configurations
  resources :resources
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
