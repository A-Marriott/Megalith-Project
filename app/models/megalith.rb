class Megalith < ApplicationRecord
  has_many :ratings
  has_many :megalith_photos
  has_many :favourites
  has_many :comments
  has_many :visiteds
  has_many :trip_megaliths
  has_many :trips, through: :trip_megaliths
end
