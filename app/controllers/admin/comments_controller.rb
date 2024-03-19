class Admin::CommentsController < ApplicationController
  def destroy
    @report = Report.find(params[:report_id])
    @comment = @report.content_type.classify.constantize.find(@report.content_id)
    @comment.destroy
    redirect_to request.referer
  end
end
