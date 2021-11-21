class Api::V1::CommentController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :task_id)
  end
end
