class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @projects = Project.all
    @projects = @projects.order(:end_date)
    @projects_funded = Pledge.pluck(:project_id).uniq.count
    @total_funding = Pledge.all.pluck(:dollar_amount).sum
  end

  def show
    @project = Project.find(params[:id])
    @user = @project.user_id
    @pledgers = @project.users # gives me all the users that pledged the specific project
    @pledger = Pledge.where(user_id: current_user).where(project_id: @project)

    @comments = @project.comments
    @comment = Comment.new

    @total_pledged = Pledge.where(project_id: @project).pluck(:dollar_amount).sum
    rescue ActiveRecord::RecordNotFound
      redirect_to(root_url, :alert => 'Project not found')
  end

  def new
    @project = Project.new
    @project.rewards.build
  end

  def create
    @project = Project.new
    @project.title = params[:project][:title]
    @project.description = params[:project][:description]
    @project.goal = params[:project][:goal]


    @project.start_date = DateTime.new(params[:project]["start_date(1i)"].to_i,
    params[:project]["start_date(2i)"].to_i,
    params[:project]["start_date(3i)"].to_i,
    params[:project]["start_date(4i)"].to_i,
    params[:project]["start_date(5i)"].to_i,
    )

    @project.end_date = DateTime.new(params[:project]["end_date(1i)"].to_i,
    params[:project]["end_date(2i)"].to_i,
    params[:project]["end_date(3i)"].to_i,
    params[:project]["end_date(4i)"].to_i,
    params[:project]["end_date(5i)"].to_i,
    )

    @project.image = params[:project][:image]
    @project.user_id = current_user.id

    if @project.save
      redirect_to root_url
    else
      flash.now[:alert] = @project.errors.full_messages
      render :new
    end
   end

end
