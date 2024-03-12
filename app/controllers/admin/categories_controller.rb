class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @category = Category.new
    @categories = Category.all
  end
  def create
    @categories = Category.all
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "カテゴリを作成しました"
    else
      render 'index'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category=Category.find(params[:id])
    @category.update(category_params)
    redirect_to admin_categories_path
  end
  def destroy
    category=Category.find(params[:id])
    category.destroy
    redirect_to request.referer, notice: "カテゴリを削除しました"
  end

private
  def category_params
     params.require(:category).permit(:name)
  end

end
