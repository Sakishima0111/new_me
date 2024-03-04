class GroupUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(params[:group_id])
    user = current_user
    group.users << user
    redirect_to group_path(group.id)
  end

  def destroy
    group = Group.find(params[:group_id])
    user = current_user
    group.users.delete(user)
    redirect_to groups_path
  end
end

# user = current_user
# group.users << user
# の記述は

# membership = Membership.new
# membership.user_id = current_user.id
# membership.group_id = group.id
# membership.save
# を省略したもの
