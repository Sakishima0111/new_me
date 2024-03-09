class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @goal = Goal.find(params[:goal_id])

    @comment = current_user.comments.new(comment_params)
    @comment.goal_id = @goal.id
    @comment.save
    @comments = @goal.comments.order(created_at: :asc)
    @goal.create_notification_comment!(current_user, @comment.id)
    # render "create"
  end

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
end
