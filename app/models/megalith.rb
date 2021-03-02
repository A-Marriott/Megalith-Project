class Megalith < ApplicationRecord
  has_many :ratings
  has_many :megalith_photos
  has_many :favourites
  has_many :comments
  has_many :trips, through: :trip_megaliths
  has_many :visiteds
  has_many :users, through: :visiteds
  # has_many_attached :megalith_photos?
  validates :name, :category, :tagline, :description, presence: true

  # validates :name, uniqueness: true
  # validates :name, uniqueness: { scope: :latitude & :longitude }
end
