class RatingsController < ApplicationController
  def create
    @megalith = Megalith.find params[:megalith_id]
    @rating = Rating.new rating_params
    @rating.megalith = @megalith
    @rating.user = current_user
    @rating.save
    update_average_rating(@megalith)
    redirect_to megalith_path(@megalith)
  end

  private
  def rating_params
    params.require(:rating).permit(:score)
  end

  def update_average_rating(megalith)
    ratings = megalith.ratings.map(&:score)
    megalith.average_rating = (ratings.sum.to_f / ratings.size).round(2)
    megalith.save
  end
end
