class Trip < ApplicationRecord
  has_many :trip_megaliths, dependent: :destroy
  has_many :other_locations
  has_many :trip_users, dependent: :destroy
  has_many :trip_photos, dependent: :destroy
  has_many :users, through: :trip_users
  has_many :megaliths, through: :trip_megaliths
end
