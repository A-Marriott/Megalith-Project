class Rating < ApplicationRecord
  belongs_to :megalith
  belongs_to :user
end
