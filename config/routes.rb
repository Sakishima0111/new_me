Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
# ユーザー用
# URL /users/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

#ユーザー側
  root to: "homes#top"
  get '/about' => "homes#about"
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # フォロー一覧
    get :followers, on: :member #フォロワー一覧
  end
  # 退会確認画面
  get  '/users/check' => 'users#check', as: 'check_user'
  # 論理削除用のルーティング
  patch  '/users/withdraw' => 'users#withdraw'
  # ransackの検索
  get "/search" => "searches#search"
  resources :cheers, only: [:index]
  resources :categories, only: [:index, :show]
  resources :goals, only: [:new, :edit, :show, :index, :create, :destroy] do
    resource :cheers, only: [:create, :destroy, :index]
    resource :comment, only: [:create, :destroy]
  end


#管理者側
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
