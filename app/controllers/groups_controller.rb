class GroupsController < ApplicationController
 before_action :authenticate_user!, except: [:index, :show]
 before_action :owner?, only: [:edit, :update, :destroy]

  #グループの新規登録
  def new
    @group = Group.new
  end
  #グループの作成
  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      @group.users << current_user
      redirect_to group_path(@group.id)
      flash[:notice] = "新規グループを作成しました"
    else
      render :new
    end
  end
  #グループ一覧
  def index
    @groups = Group.all.page(params[:page]).per(10).order(created_at: :desc)
  end
  #ログインユーザーの参加グループ一覧
  def list
    @user = User.find(current_user.id)
    @groups = @user.groups.page(params[:page]).per(10).order(created_at: :desc)
  end
  #グループ詳細ページ、投稿など
  def show
    @group = Group.find(params[:id])
    @groupposts = GroupPost.where(group_id: @group.id).all.order(created_at: :desc)
    @group_post = GroupPost.new
  end
  #グループの編集(オーナーのみ可能)
  def edit
    @group = Group.find(params[:id])
  end
  #グループの情報更新
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id)
      flash[:notice] = "グループ情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    flash[:notice] = "グループの削除に成功しました"
    redirect_to groups_path
  end
  #グループ内のメンバー一覧、フォロー可能
  def group_member
    @group = Group.find(params[:group_id])
    @users = @group.users.page(params[:page]).per(10)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
  def group_post_params
    params.require(:group_post).permit(:content)
  end
  #グループの作成者(オーナー)か
  def owner?
   group = Group.find(params[:id])
   if group.owner != current_user
     redirect_to group_path(group.id)
   end
  end
end
