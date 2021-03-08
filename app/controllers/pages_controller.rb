class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @megaliths = Megalith.all.sort_by { |h| h[:average_rating] }.reverse!
    # classmethod to find top megaliths
    # self.toprated
  end
end
