class TripsController < ApplicationController
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
    @trip = Trip.find(params[:id])
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)

    redirect_to trip_path(@trip)
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :tagline, :description)
  end
end
