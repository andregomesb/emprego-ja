Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'jobs#index'
  resources :jobs, only:[:index, :show, :new, :create, :edit, :update]
  resources :companies, only:[ :show, :new, :create, :edit, :update]
  resources :categories, only: [:show, :new, :create]
end
