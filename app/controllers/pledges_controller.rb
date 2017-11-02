class PledgesController < ApplicationController
  before_action :require_login

  def create
    @project = Project.find(params[:project_id])

    @pledge = @project.pledges.build
    @pledge.dollar_amount = params[:pledge][:dollar_amount]
    @pledge.user = current_user
    @user = @project.user_id

    if @pledge.save
      @claim = Claim.new
      @rewards = @project.rewards
      @reward = @rewards.where("dollar_amount < ?", @pledge.dollar_amount)
      @reward.max_by do |reward|
        reward.dollar_amount
      end
      @reward = @reward.to_a
      @reward = @reward[0]

      @claim = Claim.create(
      project_id: @project.id,
      user_id: @pledge.user.id,
      reward_id: @reward[0]
      )
      redirect_to project_url(@project), notice: "You have successfully backed #{@project.title}, You've earned the reward #{@reward.description}!"
    else
      flash.now[:alert] = @pledge.errors.full_messages.first
      render 'projects/show'
    end
  end

end
