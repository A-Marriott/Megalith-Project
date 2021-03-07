class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :megalith
  acts_as_votable
end
