class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user= User.find(params[:user_id])
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    @user.create_notification_follow!(current_user)
    # redirect_to request.referer
    render 'replace_btn'
  end

  def destroy
    @user= User.find(params[:user_id])
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    # redirect_to request.referer
    render 'replace_btn'
  end
end
