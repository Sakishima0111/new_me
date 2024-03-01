class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @goals = @user.goals
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def check
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(current_user.id)
      flash[:notice] = "You have updated user successfully."
    else
      @user=User.find(params[:id])
      @user.update(user_params)
      render :edit
    end
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
    
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  
  private

  def user_params
    params.require(:user).permit(:nickname, :introduction, :image)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  

end
