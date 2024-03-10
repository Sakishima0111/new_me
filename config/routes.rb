Rails.application.routes.draw do

# ユーザーログイン
devise_for :users, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in' => "user/sessions#guest_sign_in"
  end

#ユーザー側
  root to: "homes#top"
  get '/about' => "homes#about"
  # 退会確認画面
  get  '/users/check' => 'users#check', as: 'check_user'
  # 論理削除用のルーティング
  patch  '/users/withdraw' => 'users#withdraw'
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # フォロー一覧
    get :followers, on: :member #フォロワー一覧
  end
  # ransackの検索
  get "/search" => "searches#search"
  resources :groups do
    resource :group_user, only: [:create, :destroy]
  end
  resource :group_post, only: [:create]
  resources :cheers, only: [:index]
  resources :categories, only: [:show]
  resources :goals, only: [:new, :edit, :show, :index, :create, :destroy, :update] do
  patch 'goal/lookback_add' => "goals#lookback_add"
  patch 'goal/status_update' => "goals#status_update"
    resource :cheers, only: [:create, :destroy, :index]
    resources :comments, only: [:create, :destroy]
  end
  resources :chats, only: [:show, :create, :destroy]
  resources :notifications, only: [:index] do
    collection do
      post :update_checked
    end
  end
  resources :reports, only: [:new, :create]

#管理者側
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :categories, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :edit, :update,]
    resources :reports, only: [:index, :show]
  end
end
