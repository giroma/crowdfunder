class PledgesController < ApplicationController
  before_action :require_login

  def create
    @project = Project.find(params[:project_id])

    @pledge = @project.pledges.build
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.user = current_user
    @user = @project.user_id

    if @pledge.save
      # find eligible rewards and save the claim if found
      @rewards = @project.rewards
      eligible_rewards = @rewards.where("dollar_amount < ?", @pledge.dollar_amount)
      if eligible_rewards.any?
        @claim = Claim.new
        @reward = eligible_rewards.max_by{|reward| reward.dollar_amount}

        @claim = Claim.create(
          project_id: @project.id,
          user_id: @pledge.user.id,
          reward_id: @reward.id
        )
        redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}. You've earned the reward #{@reward.description}!"
      else
        # no reward, just saving pledge
        redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}."
      end
    else
      flash.now[:alert] = @pledge.errors.full_messages.first
      render 'projects/show'
    end
  end
end
