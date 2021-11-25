module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_project, only: %i[update destroy]

      def index
        projects = current_user.projects
        render json: ProjectSerializer.new(projects).serializable_hash.to_json
      end

      def create
        project = current_user.projects.new(project_params)
        if project.save
          render json: ProjectSerializer.new(project).serializable_hash.to_json
        else
          render json: project.errors.messages.to_json, status: :unprocessable_entity
        end
      end

      def update
        if @project.update(project_params)
          render json: ProjectSerializer.new(@project).serializable_hash.to_json
        else
          render json: @project.errors.messages.to_json, status: :unprocessable_entity
        end
      end

      def destroy
        @project.destroy
        head :ok
      end

      private

      def set_project
        @project = current_user.projects.find(params[:id])
      end

      def project_params
        params.permit(:name)
      end
    end
  end
end
