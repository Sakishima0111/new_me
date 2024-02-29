Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :users, controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}
  get 'cheer/index'
  get 'categories/index'
  get 'categories/show'
  get 'goals/new'
  get 'goals/edit'
  get 'goals/show'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  root to: "homes#top"
  get 'homes/about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
