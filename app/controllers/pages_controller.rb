class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @megaliths = Megalith.all.first(10)
    # classmethod to find top megaliths
    # self.toprated
  end
end
