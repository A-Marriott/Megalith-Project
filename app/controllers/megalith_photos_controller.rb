class MegalithPhotosController < ApplicationController
  def upvote
    @photo = MegalithPhoto.find params[:id]
    @photo.liked_by current_user
    redirect_to megalith_path(@photo.megalith)
  end

  def create
    @megalith_photo = MegalithPhoto.new megalith_photo_params
    @megalith = Megalith.find params[:megalith_id]
    @megalith_photo.megalith = @megalith
    @megalith_photo.user = current_user
    @megalith_photo.save
    redirect_to megalith_path(@megalith)
  end

  private

  def megalith_photo_params
    params.require(:megalith_photo).permit(:photo)
  end
end
