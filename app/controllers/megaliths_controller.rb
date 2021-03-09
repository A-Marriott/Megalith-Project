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
        infoWindow: render_to_string(partial: "shared/info_window", locals: { megalith: megalith })
      }
    end
  end

  def show
    if params[:id] == "random"
      redirect_to megalith_path Megalith.all.sample
    else
      @megalith = Megalith.find(params[:id])
      @megalith_photo = MegalithPhoto.new
      unless @my_rating = Rating.where(user: current_user, megalith: @megalith).first
        @rating = Rating.new
      end
      @average_rating = @megalith.average_rating
      @trips = @megalith.trips.where(published: true)
      @markers = [{lat:@megalith.latitude, lng:@megalith.longitude}]
      @comment = Comment.new
      @comment.megalith_id = @megalith.id
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
