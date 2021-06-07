Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  namespace :admin do
    resources :courses do
      resources :lessons
    end
  end

  resources :courses, only: %i[show] do
    resources :lessons, only: %i[show]
    post 'enroll', on: :member
    get 'my_courses', on: :collection
  end

  resources :instructors
end
