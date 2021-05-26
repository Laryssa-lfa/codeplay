Rails.application.routes.draw do
  root 'home#index'
  resources :courses do
    resources :lessons
  end
  resources :instructors
end
