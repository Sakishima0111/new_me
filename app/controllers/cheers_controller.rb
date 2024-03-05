class CheersController < ApplicationController
  def create
    @goal = Goal.find(params[:goal_id])
    @cheer = current_user.cheers.new(goal_id: @goal.id)
    @cheer.save
    if current_user != @goal.user
      @goal.create_notification_cheer_goal!(current_user)
    end
    redirect_to request.referer
  end
  
  def destroy
    @goal = Goal.find(params[:goal_id])
    @cheer = current_user.cheers.find_by(goal_id: @goal.id)
    @cheer.destroy
    redirect_to request.referer
  end
  
  def index
  end
end
