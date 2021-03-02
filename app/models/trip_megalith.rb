class TripMegalith < ApplicationRecord
  belongs_to :trip
  belongs_to :megalith

  validates :main, presence: true
end
