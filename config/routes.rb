Rails.application.routes.draw do
# ユーザー用
# URL /users/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

#ユーザー側
  root to: "homes#top"
  get '/about' => "homes#about"
  resources :users, only: [:show, :edit, :update]
  # 退会確認画面
  get  '/users/check' => 'customers#check'
  # 論理削除用のルーティング
  patch  '/users/withdraw' => 'customers#withdraw'
  resources :cheers, only: [:index]
  resources :categories, only: [:index, :show]
  resources :goals, only: [:new, :edit, :show]


#管理者側
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
