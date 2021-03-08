class MegalithPhotosController < ApplicationController
  def upvote
    @photo = MegalithPhoto.find params[:id]
    @photo.liked_by current_user
    redirect_to megalith_path(@photo.megalith)
  end
end
