class CommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]
  before_action :authenticate_user!

  #コメントの作成(Ajax)
  def create
    @goal = Goal.find(params[:goal_id])
    @comment = current_user.comments.new(comment_params)
    @comment.goal_id = @goal.id
    if @comment.save
    @comments = @goal.comments.order(created_at: :asc)
    @goal.create_notification_comment!(current_user, @comment.id)
    #内容が空の場合は通知を作成しない＆レコードに残さない
    end
  end
  
  #コメントの削除
  def destroy
    @goal = Goal.find(params[:goal_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comments = @goal.comments.order(created_at: :asc)
    # render "destroy"
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end
  #ログインユーザーかどうか、異なる場合はアクション制限リダイレクト先へ
  def is_matching_login_user
      comment = Comment.find(params[:id])
    unless comment.user.id == current_user.id
      redirect_to goals_path
    end
  end
end
