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
  end

  def edit
    @main_megalith = @trip.trip_megaliths.where(main: true).first.megalith
    @search_users = User.search_users(params[:user_query]) if params[:user_query]
    @trip_megaliths = @trip.trip_megaliths.includes(:megalith)
    @search_megaliths = Megalith.near([@main_megalith.latitude, @main_megalith.longitude], 5)
                                .reject { |megalith| @trip.megaliths.include? megalith }
                                .first(5)
    @trip_users = @trip.users
    respond_to do |format|
      format.html
      format.js
    end
    @megalith = @trip.trip_megaliths.find_by(main: true).megalith
  end

  def update
    if params[:trip] && params[:trip][:photos]
      params[:trip][:photos].each do |photo|
        TripPhoto.create(trip: @trip, photo: photo)
      end
    elsif params[:trip]
      @trip.update(trip_params)
    end

    redirect_to edit_trip_path(@trip), notice: "Trip updated"
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
