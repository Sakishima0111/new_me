Rails.application.routes.draw do
  get 'cheer/index'
  get 'categories/index'
  get 'categories/show'
  get 'goals/new'
  get 'goals/edit'
  get 'goals/show'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'homes/top'
  get 'homes/about'
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
