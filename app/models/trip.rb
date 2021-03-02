class Trip < ApplicationRecord
  has_many :trip_megaliths
  has_many :trip_users
  has_many :trip_photos
  has_many :users, through: :trip_users
  has_many :megaliths, through: :trip_megaliths
  has_many :other_locations
  validates :name, :duration, :tagline, :description, :top_tip, :date_visited, :upvote_score, presence: true
end
