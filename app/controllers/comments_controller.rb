class CommentsController < ApplicationController
  def create
    @comment = Comment.create
    @project = Project.find(params[:project_id])
    @comment.comment = params[:comment][:comment]
    @comment.project = @project
    @comment.user_id = current_user.id

    if @comment.save
      flash.notice = "Comment has been successfully created."
      redirect_to @project
    else
      render project_path(@project)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @project = Project.find(params[:project_id])
    @comment.comment = params[:comment][:comment]
    @comment.project = @project

    if @comment.save
      flash.notice = "Comment has been successfully updated."
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment has been successfully deleted."
      redirect_to project_path(params[:project_id])
    else
      render :show
    end
  end

end
