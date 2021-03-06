class FavouritesController < ApplicationController
  def create
    @favourite = Favourite.new

    @favourite.save
      redirect_to megalith_path(@megalith)
      flash[:alert] = "Ooops! something went wrong" unless @favorite.save
end
