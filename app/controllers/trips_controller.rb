class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy, :finalise_trip_edit, :publish_trip]

  def new
    @megalith = Megalith.find(params[:megalith_id])
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      TripUser.create(user: current_user, trip: @trip)
      TripMegalith.create(megalith_id: params[:megalith_id], trip: @trip, main: true)
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def show
    @main_megalith = @trip.trip_megaliths.where(main: true).first.megalith
    @other_megaliths = @trip.megaliths.reject { |lith| lith == @main_megalith }
    @markers = @trip.megaliths.map do |megalith|
      {
        lat: megalith.latitude,
        lng: megalith.longitude,
        infoWindow: render_to_string(partial: "shared/info_window", locals: { megalith: megalith }),
        image_url: helpers.asset_url('logo.png')
      }
    end
  end

  def upvote
    @trip = Trip.find params[:id]
    @trip.liked_by current_user
    if params[:redirect_type] == 'megalith'
      redirect_to megalith_path(params[:redirect], anchor: 'trips')
    elsif params[:redirect_type] == 'home'
      redirect_to root_path(anchor: 'popular-trips')
      # this if is so that upvoting sends the user back to the megalith show page if that is where they upvoted
      # if the tirp card shows elsewhere they need a different redirect.
    end
  end

  def edit
    @main_megalith = @trip.trip_megaliths.where(main: true).first.megalith
    @search_users = User.search_users(params[:user_query]) if params[:user_query]
    @trip_megaliths = @trip.trip_megaliths.includes(:megalith)
    @active_tab = params[:active_tab] if params[:active_tab]
    @search_megaliths = Megalith.near([@main_megalith.latitude, @main_megalith.longitude], 5)
                                .reject { |megalith| @trip.megaliths.include? megalith }
                                .first(5)
    @markers = (@search_megaliths+@trip_megaliths.map(&:megalith)).map do |megalith|
      {
        lat: megalith.latitude,
        lng: megalith.longitude,
        infoWindow: render_to_string(partial: "shared/info_window", locals: { megalith: megalith }),
        image_url: helpers.asset_url('logo.png')
      }
    end
    @trip_users = @trip.users
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if params[:commit] == "Upload Photos"
      params[:trip][:photos].each do |photo|
        TripPhoto.create(trip: @trip, photo: photo)
      end
      redirect_to edit_trip_path(@trip, anchor: 'trip-edit-title'), notice: "Trip updated"
    elsif params[:commit] == "Update Details" || params[:commit] == "Confirm Date"
      @trip.update(trip_params)
      redirect_to edit_trip_path(@trip, anchor: 'trip-edit-title'), notice: "Trip updated"
    elsif params[:commit] == "Publish Trip"
      # @trip.update(published: true)
      @trip.published = true
      @trip.save
      redirect_to trip_path(@trip), notice: "Congratulations, other megalithusiasts can see and upvote your trip now"
    end
  end

  def destroy
    @trip.destroy

    redirect_to root_path
  end

  def finalise_trip_edit
    @megalith = @trip.trip_megaliths.find_by(main: true).megalith
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :tagline, :description, :top_tip, :date_visited, :published)
  end
end
