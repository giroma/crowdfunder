class SearchController < ApplicationController
  def index
    @projects = Project.where("(title LIKE ?)", "%#{params[:search][:input].capitalize}%")
  end
end
