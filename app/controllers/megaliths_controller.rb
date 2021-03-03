class MegalithsController < ApplicationController
  def index
    @megaliths = Megalith.all
  end

  def show
    @megalith = Megalith.find(params[:id])
  end

  def new
    @megalith = Megalith.new
  end

  def create
    @megalith = Megalith.new megalith_params
    if params[:megalith][:photos] && @megalith.save
        params[:megalith][:photos].each do |photo|
          MegalithPhoto.create(user: current_user, megalith: @megalith, photo: photo)
        end
      redirect_to megalith_path(@megalith)
    elsif @megalith.valid?
      flash[:alert] = "Please upload at least one photo"
      render :new
    else
      render :new
    end
  end

  private

  def megalith_params
    params.require(:megalith).permit(:name, :category, :tagline, :description)
  end
end
