class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :megalith

  validates :text, :upvotes, presence: true
end
