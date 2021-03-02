class Rating < ApplicationRecord
  belongs_to :megalith
  belongs_to :user

  validates :score, presence: true
end
