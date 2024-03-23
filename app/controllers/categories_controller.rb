class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @goals = Goal.where(category_id: @category.id, status: Goal.statuses[:in_progress]).order(created_at: :desc)
  end
end
