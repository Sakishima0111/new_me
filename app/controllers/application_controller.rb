class ApplicationController < ActionController::Base
before_action :search
  #ransackを使った検索
  def search
    @q = User.ransack(params[:q])
    @item = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end
end