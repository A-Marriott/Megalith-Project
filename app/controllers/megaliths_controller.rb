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

end
