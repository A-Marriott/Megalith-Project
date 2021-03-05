class Megalith < ApplicationRecord
  has_many :ratings
  has_many :megalith_photos, dependent: :destroy
  has_many :comments
  has_many :trip_megaliths
  has_many :trips, through: :trip_megaliths

  reverse_geocoded_by :latitude, :longitude
end
