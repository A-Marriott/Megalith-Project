class TripUsersController < ApplicationController
  def create
    @trip = Trip.find params[:trip]
    @user = User.find params[:user]
    TripUser.create(trip: @trip, user: @user)
    redirect_to edit_trip_path(@trip)
  end

  def destroy
    @trip = Trip.find params[:trip]
    @trip_user = TripUser.find_by!(trip: params[:trip], user: params[:user])
    @trip_user.destroy
    redirect_to edit_trip_path(@trip)
  end
end
