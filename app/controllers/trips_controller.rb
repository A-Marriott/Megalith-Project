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
  end

  def update
    if params[:trip][:top_tip]
      @trip.update(finalise_trip_params)
      redirect_to trip_path(@trip)
    else
      @trip.update(trip_params)
      redirect_to trip_path(@trip)
    end
  end

  def destroy
    @trip.destroy

    redirect_to root_path
  end

  def finalise_trip_edit
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :tagline, :description)
  end

  def finalise_trip_params
    params.require(:trip).permit(:name, :tagline, :description, :top_tip, :date_visited, :published)
  end
end
