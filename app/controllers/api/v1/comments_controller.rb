module Api
  module V1
    class CommentsController < ApplicationController
      def create
        @comment = Comment.create(comment_params)
        render json: CommentSerializer.new(@comment).serializable_hash.to_json
      end

      def destroy
        @comment.destroy
        head :ok
      end

      private

      def comment_params
        params.permit(:name, :task_id)
      end
    end
  end
end
