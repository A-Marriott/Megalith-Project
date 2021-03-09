class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.megalith_id = params[:megalith_id]
    @comment.user_id = current_user.id

    @comment.save

    redirect_to megalith_path(@comment.megalith, anchor: "comments"), notice: "Comment posted"
  end

  def upvote
    @comment = Comment.find params[:id]
    @comment.liked_by current_user
    redirect_to megalith_path(@comment.megalith, anchor: "comment-#{@comment.id}")
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
