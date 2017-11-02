class OwnerUpdatesController < ApplicationController
  def create
    @project_update = OwnerUpdate.create
    @project = Project.find(params[:project_id])
    @project_update.project_update = params[:owner_update][:project_update]
    @project_update.project = @project
    @project_update.user_id = @project.user_id

    if @project_update.save
      flash.notice = "Update has been successfully created."
      redirect_to @project
    else
      render project_path(@project)
    end
  end

  def edit
    @project_update = OwnerUpdate.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def update
    @project_update = OwnerUpdate.find(params[:id])
    @project = Project.find(params[:project_id])
    @project_update.project_update = params[:owner_update][:project_update]
    @project_update.project = @project

    if @project_update.save
      flash.notice = "Update has been successfully updated."
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project_update = OwnerUpdate.find(params[:id])

    if @project_update.destroy
      flash[:notice] = "Update has been successfully deleted."
      redirect_to project_path(params[:project_id])
    else
      render :show
    end
  end
end
