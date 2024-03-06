class CheersController < ApplicationController
  before_action :authenticate_user!
  def create
    @goal = Goal.find(params[:goal_id])
    @cheer = current_user.cheers.new(goal_id: @goal.id)
    @cheer.save
    if current_user != @goal.user
      @goal.create_notification_cheer_goal!(current_user)
    end
    render 'replace_btn'
  end

  def destroy
    @goal = Goal.find(params[:goal_id])
    @cheer = current_user.cheers.find_by(goal_id: @goal.id)
    @cheer.destroy
    render 'replace_btn'
  end

  def index
  end
end
