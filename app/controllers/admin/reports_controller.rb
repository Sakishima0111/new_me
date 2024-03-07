class Admin::ReportsController < ApplicationController
  def index
    @reports = Report.all.page(params[:page]).per(10)
    
  end

  def show
    
  end
end
