class Admin::CommentsController < ApplicationController
  def destroy
    @report = Report.find(params[:report_id])
    @comment = Comment.find(@report.content_id)
    @comment.destroy
    redirect_to request.referer
  end
end
