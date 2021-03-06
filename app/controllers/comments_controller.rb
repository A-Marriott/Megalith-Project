class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user_id = current_user.id
    @comment.megalith_id = params[:megalith_id]
    raise
    if @comment.save
      redirect_back fallback_location: @megalith, notice: 'Your comment was successfully posted!'
    else
      redirect_back fallback_location: @megalith, notice: "Your comment wasn't posted!"
    end
  end

  def edit
    @comment = @commentable.comments.find(params[:id])
  end

  def update
    @comment = @commentable.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @commentable, notice: "Your comment was successfully updated"
    else
      render 'index'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Megalith.find_by_id(params[:megalith_id]) if params[:megalith_id]
  end

end
