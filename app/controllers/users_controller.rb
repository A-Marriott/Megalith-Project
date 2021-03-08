class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @comments = @user.comments
    @photos = @user.megalith_photos
    @favourites = @user.favourited
    @visiteds = @user.visited
  end
end
