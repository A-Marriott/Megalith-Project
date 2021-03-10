class TripMegalithsController < ApplicationController
  def create
    @trip = Trip.find params[:trip]
    @megalith = Megalith.find params[:megalith]
    TripMegalith.create(trip: @trip, megalith: @megalith)
    redirect_to edit_trip_path(@trip, anchor: "megaliths-anchor", active_tab: params[:active_tab])
  end

  def destroy
    @trip = Trip.find params[:trip]
    @trip_megalith = TripMegalith.find_by(trip: params[:trip], megalith: params[:megalith])
    @trip_megalith.destroy
    redirect_to edit_trip_path(@trip, anchor: "megaliths-anchor", active_tab: params[:active_tab])
  end
end
