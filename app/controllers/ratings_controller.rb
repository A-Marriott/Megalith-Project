class RatingsController < ApplicationController
  def create
    @megalith = Megalith.find params[:megalith_id]
    @rating = Rating.new rating_params
    @rating.megalith = @megalith
    @rating.user = current_user
    @rating.save
    redirect_to megalith_path(@megalith)
  end

  private

  def rating_params
    params.require(:rating).permit(:score)
  end
end
