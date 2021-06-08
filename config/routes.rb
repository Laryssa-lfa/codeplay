Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  devise_for :students

  namespace :admin do
    resources :courses do
      resources :lessons
    end
  end

  namespace :api do
    namespace :v1 do
      resources :courses, only: %i[index show create update destroy], param: :code 
    end
  end

  resources :courses, only: %i[show] do
    resources :lessons, only: %i[show]
    post 'enroll', on: :member
    get 'my_courses', on: :collection
  end

  resources :instructors
end
