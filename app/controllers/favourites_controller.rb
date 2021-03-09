class FavouritesController < ApplicationController
  def create
    @megalith = Megalith.find params[:megalith_id]
    Favourite.create(megalith: @megalith, user: current_user)
    redirect_to megalith_path(@megalith)
  end

  def destroy
    @megalith = Megalith.find params[:megalith_id]
    @favourite = Favourite.where(megalith: @megalith, user: current_user).first
    @favourite.destroy
    redirect_to megalith_path(@megalith)
  end
end
