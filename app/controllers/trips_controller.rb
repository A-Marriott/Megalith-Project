class TripsController < ApplicationController
  def new
    @megalith = Megalith.find(params[:megalith_id])
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      TripUser.create(user: current_user, trip: @trip)
      TripMegalith.create(megalith: params[:megalith_id], trip: @trip, main: true)
      redirect_to trip_path(@megalith)
    elsif @megalith.valid?
      flash[:alert] = "Please upload at least one photo"
      render :new
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :tagline, :description)
  end
end
