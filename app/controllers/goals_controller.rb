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
    @comments = @goal.comments.order(created_at: :asc)
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
      redirect_to goal_path(@goal), notice: "目標を修正しました"
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
  # 目標の振り返りを追加するアクション。edit,updateと同じ役割。
  def lookback_add
    @goal = Goal.find(params[:goal_id])
    if @goal.update(goal_params)
      redirect_to goal_path(@goal), notice: "目標の振り返りが完了しました。"
    else
      render "show"
    end
  end
  # ステータスを詳細ページで修正
  def status_update
    @goal = Goal.find(params[:goal_id])
    if @goal.update(goal_params)
      redirect_to goal_path(@goal), notice: "ステータスの変更が完了しました。"
    else
      render "show"
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :content, :deadline, :reward, :status, :category_id, :lookback)
  end
  def is_matching_login_user
      goal = Goal.find(params[:id])
    unless goal.user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
