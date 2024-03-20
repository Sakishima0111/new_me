class Admin::ReportsController < ApplicationController
  def index
    @reports = Report.all.page(params[:page]).per(10)
  end

  def show
    @report = Report.find(params[:id])
    @comment = @report.content
  end

  def update
    @report = Report.find(params[:id])
    if @report.update!(report_params) #ストロングパラメータを通して更新
      flash[:notice] = "対応ステータスを更新しました。"
      redirect_to request.referer
    end
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end
end
