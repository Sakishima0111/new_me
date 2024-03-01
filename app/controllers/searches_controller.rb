class SearchesController < ApplicationController

  def search
    @q = User.ransack(params[:q])
    @item = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end
end
