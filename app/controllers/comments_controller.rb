class CommentsController < ApplicationController
  def create
    goal = Goal.find(params[:goal_id])
    comment = current_user.comments.new(comment_params)
    comment.goal_id = goal.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
