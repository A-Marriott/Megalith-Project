class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @megaliths = Megalith.all.sort { |a,b| a && b ? a <=> b : a ? 1 : -1 }.reverse
  end
end
