class GoalsController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    @goal.save
    redirect_to user_path(current_user.id), notice: "新たな目標を設定しました！"
  end

  def show
    @goal = Goal.find(params[:id])
    @comment = Comment.new
  end

  def index
    # 新しい投稿が上にくるように表示
    @goals = Goal.where(status: Goal.statuses[:in_progress]).order(created_at: :desc)
    @categories = Category.all
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_path(@goal), notice: "You have updated book successfully."
    else
      @goal = Goal.find(params[:id])
      @goal.update(goal_params)
      render "edit"
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :content, :deadline, :reward, :status, :category_id)
  end
  def is_matching_login_user
      goal = Goal.find(params[:id])
    unless goal.user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
