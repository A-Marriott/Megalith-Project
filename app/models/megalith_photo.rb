class MegalithPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :megalith
  has_one_attached :photo

  validates :upvote_score, presence: true
end
