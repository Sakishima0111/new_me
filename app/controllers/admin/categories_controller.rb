class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @category = Category.new
    @categories = Category.all.page(params[:page]).per(10)
  end
  def create
    @categories = Category.all.page(params[:page]).per(10)
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
    if@category.update(category_params)
      redirect_to admin_categories_path
    else
      render "edit"
    end
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
