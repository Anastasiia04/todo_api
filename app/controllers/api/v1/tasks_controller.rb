module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_task, only: %i[update destroy complete]

      def create
        task = current_user.tasks.new(task_params)
        if task.save
          render json: TaskSerializer.new(task).serializable_hash.to_json
        else
          render json: task.errors.messages.to_json
        end
      end

      def update
        if @task.update(task_params)
          render json: TaskSerializer.new(@task).serializable_hash.to_json
        else
          render json: @task.errors.messages.to_json
        end
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
        @task = current_user.tasks.find(params[:id])
      end

      def task_params
        params.permit(:name, :project_id)
      end
    end
  end
end
