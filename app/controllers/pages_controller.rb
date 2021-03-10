class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @megaliths = Megalith.all
                         .sort { |a,b| a.average_rating && b.average_rating ? a.average_rating <=> b.average_rating : a.average_rating ? 1 : -1 }
                         .reverse
                         .first(10)
  end
end
