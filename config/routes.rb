Rails.application.routes.draw do
  root to: 'tests#index'
  
  resources :tests
  resources :questions, shallow: true
end
