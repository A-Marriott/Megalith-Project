class MegalithPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :megalith
  has_one_attached :photo
  acts_as_votable
end
