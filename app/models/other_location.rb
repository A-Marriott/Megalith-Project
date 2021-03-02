class OtherLocation < ApplicationRecord
  belongs_to :trip

  validates :name, :category, :address, :upvote_score, presence: true
  validates :name, uniqueness: { scope: :address }
end
