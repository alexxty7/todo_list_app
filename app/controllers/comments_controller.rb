class CommentsController < ApplicationController
  before_action :process_params, only: :create
  before_action :load_comment, only: :destroy
  # before_action :authenticate_user!
  # authorize_resource
  
  def create
    @comment = Comment.create(comment_params)
    respond_with @comment
  end

  def destroy
    respond_with @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :file_attachment, :task_id)
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def process_params
    if params[:file]
      params[:comment][:file_attachment] = params[:file]
    end
  end
end