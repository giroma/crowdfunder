class ClaimsController < ApplicationController

  def create
    @project = Project.find(params[:id])
    @reward = Reward.find(params[:id])
    @user = Pledge.where(user_id: current_user).where(project_id: @project) # user must have pledged to claim reward
    @claim = Claim.create
    @claim.project_id = @project.id
    @claim.reward_id = @reward.id
    @claim.user_id = @user.id
  end

end
