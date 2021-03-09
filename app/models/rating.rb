class Rating < ApplicationRecord
  belongs_to :megalith
  belongs_to :user
  after_save :update_average_rating

  def update_average_rating
    ratings = megalith.ratings.map(&:score)
    megalith.average_rating = (ratings.sum.to_f / ratings.size).round(2)
    megalith.save
  end
end
