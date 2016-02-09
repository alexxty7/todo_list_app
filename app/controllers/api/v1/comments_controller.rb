class Api::V1::CommentsController < ApplicationController
  before_action :process_params, only: :create

  def create
    @comment = Comment.create(comment_params)
    respond_with :api, :v1, @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_with @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :file_attachment, :task_id)
  end

  def process_params
    if params[:file]
      params[:comment][:file_attachment] = params[:file]
    end
  end
end