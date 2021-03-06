class MegalithsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      @queryhash = JSON.parse(params[:query])
      @megaliths = Megalith.near(@queryhash['coordinates'].reverse, 10)
    else
      @megaliths = Megalith.all
    end
    @markers = @megaliths.map do |megalith|
      {
        lat: megalith.latitude,
        lng: megalith.longitude,
        infoWindow: render_to_string(partial: "shared/info_window", locals: { megalith: megalith }),
        image_url: helpers.asset_url('logo.png')
      }
    end
  end

  def show
    if params[:id] == "random"
      redirect_to megalith_path Megalith.all.sample
    else
      @megalith = Megalith.find(params[:id])
      @megalith_photo = MegalithPhoto.new
      @photos = @megalith.megalith_photos
                 .map { |t| [t, t.get_likes.size] }
                 .sort { |a,b| b[1] <=> a[1] }
                 .map { |arr| arr[0] }
      unless @my_rating = Rating.where(user: current_user, megalith: @megalith).first
        @rating = Rating.new
      end
      @other_megaliths = Megalith.near([@megalith.latitude, @megalith.longitude], 5)
                                  .reject { |megalith| megalith == @megalith }
                                  .first(5)
      @average_rating = @megalith.average_rating
      @trip = Trip.new
      @trips = @megalith.trips.where(published: true)
      @markers = [{lat:@megalith.latitude, lng:@megalith.longitude, image_url: helpers.asset_url('logo.png')}]
      @comment = Comment.new
      @comments = @megalith.comments.map { |t| [t, t.get_likes.size] }
                                    .sort { |a,b| b[1] <=> a[1] }
                                    .map { |arr| arr[0] }
    end

  end

  def new
    @megalith = Megalith.new
  end

  def create
    @megalith = Megalith.new megalith_params
    if params[:megalith][:photos] && @megalith.save
        params[:megalith][:photos].each do |photo|
          MegalithPhoto.create(user: current_user, megalith: @megalith, photo: photo)
        end
      redirect_to megalith_path(@megalith)
    elsif @megalith.valid?
      flash[:alert] = "Please upload at least one photo"
      render :new
    else
      render :new
    end
  end


  private

  def megalith_params
    params.require(:megalith).permit(:name, :category, :tagline, :description)
  end
end
