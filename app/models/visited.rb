class Visited < ApplicationRecord
  belongs_to :megalith
  belongs_to :user

  validates :megalith, uniqueness: { scope: :user }
end
