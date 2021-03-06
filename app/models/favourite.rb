class Favourite < ApplicationRecord
  belongs_to :megalith
  belongs_to :user
  validates :user_id, uniqueness: { scope: :megalith_id }
end
