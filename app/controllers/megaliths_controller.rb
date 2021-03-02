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
    if @megalith.save
      MegalithPhoto.create(user: current_user, megalith: Megalith.last, photo: params[:megalith][:photo]) if params[:megalith][:photo]
      redirect_to megalith_path(@megalith)
    else
      render :new
    end
  end

  private

  def megalith_params
    params.require(:megalith).permit(:name, :category, :tagline, :description)
  end

  # def megalith_photo_params
  #   params.require(:megalith_photo).permit(:photo)
  # end
end
