class TripsController < ApplicationController
  def new
    @megalith = Megalith.find(params[:megalith_id])
    @trip = Trip.new
  end

  def create
  end
end
