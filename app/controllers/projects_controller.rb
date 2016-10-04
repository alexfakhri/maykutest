class ProjectsController < ApplicationController

  def index
    @project_count = Project.all
    @projects = Project.all
  end

  def new
    @project_count = Project.all
    @project = Project.new
  end

  def create
    Project.create(project_params)
    redirect_to '/projects'
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:caption, :image)
  end

end
