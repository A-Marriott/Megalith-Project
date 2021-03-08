class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @user.recalculate_badge_scores
    @comments = @user.comments
    @photos = @user.megalith_photos
    @favourites = @user.favourited
    @visiteds = @user.visited
    @planned_trips = @user.trips.where(date_visited: nil)
    @completed_trips = @user.trips.where.not(date_visited: nil)
  end
end
