class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @megaliths = Megalith.all
                         .sort { |a,b| a.average_rating && b.average_rating ? a.average_rating <=> b.average_rating : a.average_rating ? 1 : -1 }
                         .reverse
                         .first(10)
    @trips = Trip.where(published: true)
                 .map { |t| [t, t.get_likes.size] }
                 .sort { |a,b| b[1] <=> a[1] }
                 .map { |arr| arr[0] }
                 .first(10)
    @trip = Trip.new
  end
end
