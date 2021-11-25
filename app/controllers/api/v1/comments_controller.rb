module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_task, only: :create

      def create
        comment = @task.comments.new(comment_params)
        if comment.save
          render json: CommentSerializer.new(comment).serializable_hash.to_json
        else
          render json: comment.errors.messages.to_json, status: :unprocessable_entity
        end
      end

      def destroy
        current_user.comments.find(params[:id]).destroy
        head :ok
      end

      private

      def comment_params
        params.permit(:name, :task_id)
      end

      def set_task
        @task = current_user.tasks.find(params[:task_id])
      end
    end
  end
end
