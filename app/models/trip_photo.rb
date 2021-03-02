class TripPhoto < ApplicationRecord
  belongs_to :trip
  has_one_attached :photo
end
