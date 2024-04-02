class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :withdraw]
  before_action :is_matching_guest_user, only: [:edit, :update, :withdraw]

  #ユーザーのプロフィールページ
  def show
    @user = User.find(params[:id])
    # 進捗ステータスごとの目標呼び出し
    @in_progress_goals = @user.goals.where(status: Goal.statuses[:in_progress]).page(params[:page]).per(9)
    @completed_goals = @user.goals.where(status: Goal.statuses[:completed]).page(params[:page]).per(9)
    @not_started_goals = @user.goals.where(status: Goal.statuses[:not_started]).page(params[:page]).per(9)
  end

  #ユーザーのプロフィール編集画面
  def edit
    @user = User.find(current_user.id)
  end

  #ユーザーの退会画面
  def check
    @user = User.find(current_user.id)
  end

  #ユーザープロフィール更新
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(current_user.id)
      flash[:notice] = "ユーザー情報を更新しました！"
    else
      @user=User.find(params[:id])
      @user.update(user_params)
      render :edit
    end
  end

  # 退会処理に関する記述
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  #ユーザーのフォロー一覧
  def follows
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(10)
  end

  #ユーザーのフォロワー一覧
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :introduction, :image)
  end
  #ゲストユーザーのアクション制限
  def is_matching_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user.id)
    end
  end

  #ログインユーザーとアクションをするユーザーは一致しているか、していなければリダイレクト
  def is_matching_login_user
    user = User.find(params[:id])
    user.id == current_user.id && user.email != "guest@example.com"
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
