class SearchController < ApplicationController
  def index
    projects_search = Project.where("title ILIKE ?", "%#{params[:search][:input]}%").to_a
    categories_search = Category.where("name ILIKE ?", "%#{params[:search][:input]}%").map {|c| c.projects}

    @projects = (projects_search + categories_search).flatten


  end
end
