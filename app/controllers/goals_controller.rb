class GoalsController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @Goal.user_id = current_user.id
    @Goal.save
    redirect_to user_path(current_user.id), notice: "新たな目標を設定しました！"
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def index
    @goals = Goal.all
  end 
  
  def edit
    @goal = Goal.find(params[:id])
  end
  
  def update
    goal = Goal.find(params[:id])
    if goal.update(goal_params)
       redirect_to user_path(current_user.id)
       flash[:notice] = "目標を編集しました！"
    else
      @goal=Goal.find(params[:id])
      @goal.update(goal_params)
      render :edit
    end
  end  
  
  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to user_path(current_user.id)
  end

  private
  
  def goal_params
    params.require(:goal).permit(:title, :content, :deadline, :reward, :status)
  end
  def is_matching_login_user
      goal = Goal.find(params[:id])
    unless goal.user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
