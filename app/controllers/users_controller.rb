class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @user.recalculate_badge_scores
  end
end
