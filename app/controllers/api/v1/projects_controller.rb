class Api::V1::ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    @project = Project.create(project_params)
  end

  def update
    @project.update(project_params)
  end

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
