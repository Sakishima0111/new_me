class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def edit
    
  end
  
  def update
    
  end  

  private
  
  def goal_params
    params.require(:goal).permit(:title, :content, :deadline, :reward, :status)
  end
end
