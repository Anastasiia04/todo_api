module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        @projects = Project.all
        render json: ProjectSerializer.new(@projects).serializable_hash.to_json
      end

      def create
        @project = Project.create(project_params)
        render json: ProjectSerializer.new(@project).serializable_hash.to_json
      end

      def update
        @project.update(project_params)
        render json: ProjectSerializer.new(@project).serializable_hash.to_json
      end

      def destroy
        @project.destroy
        head :ok
      end

      private

      def project_params
        params.permit(:name)
      end
    end
  end
end
