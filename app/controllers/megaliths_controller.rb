class MegalithsController < ApplicationController
  def index
    @megaliths = Megalith.all

    @markers = @megaliths.map do |megalith|
      {
        lat: megalith.latitude,
        lng: megalith.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { megalith: megalith })
      }
    end
  end

  def show
    @megalith = Megalith.find(params[:id])

    @markers = [{lat:@megalith.latitude, lng:@megalith.longitude}]
  end

  def new
    @megalith = Megalith.new
  end




end
