module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[complete update destroy]

      def create
        @task = Task.create(task_params)
        render json: TaskSerializer.new(@task).serializable_hash.to_json
      end

      def update
        @task.update(task_params)
        render json: TaskSerializer.new(@task).serializable_hash.to_json
      end

      def destroy
        @task.destroy
        head :ok
      end

      def complete
        @task.update(completed: true)
        render json: TaskSerializer.new(@task).serializable_hash.to_json
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.permit(:name, :project_id)
      end
    end
  end
end
