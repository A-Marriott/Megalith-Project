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

  def create_from_trip_photo
    @trip_photo = TripPhoto.find params[:id]
    @photo_key = @trip_photo.photo.key
    @megalith = Megalith.find params[:megalith_photo][:megalith]
    @active_tab = params[:active_tab]
    @megalith_photo = MegalithPhoto.new(megalith: @megalith, user: current_user, photo_key: @photo_key)
  end

  private

  def megalith_photo_params
    params.require(:megalith_photo).permit(:photo)
  end
end
