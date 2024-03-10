class GroupsController < ApplicationController
 before_action :authenticate_user!, except: [:index, :show]
 before_action :owner?, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      @group.users << current_user
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @groupposts = GroupPost.where(group_id: @group.id).all.order(created_at: :desc)
    @group_post = GroupPost.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to root_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
  def group_post_params
    params.require(:group_post).permit(:content)
  end
  def owner?
   group = Group.find(params[:id])
   if group.owner != current_user
     redirect_to group_path(group.id)
   end
  end
end
