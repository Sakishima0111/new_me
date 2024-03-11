class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.page(params[:page]).per(10)
  end
  def edit
    @user = User.find(params[:id]) #編集したいuserのIDを取得
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) #ストロングパラメータを通して更新
      redirect_to admin_users_path, notice: "#{@user.nickname}さんの会員ステータスを更新しました"
    else
      render "edit"
    end
  end
  private

  def user_params
    params.require(:user).permit(:is_active)
  end
end
