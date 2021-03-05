class TripMegalithsController < ApplicationController
  def create
    @trip = Trip.find params[:trip]
    @megalith = User.find params[:megalith]
    TripMegalith.create(trip: @trip, megalith: @megalith)
    redirect_to edit_trip_path(@trip)
  end
end
