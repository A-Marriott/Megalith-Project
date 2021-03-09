class VisitedsController < ApplicationController
  def create
    @megalith = Megalith.find params[:megalith_id]
    Visited.create(megalith: @megalith, user: current_user)
    redirect_to megalith_path(@megalith)
  end
end
