class OtherLocation < ApplicationRecord
  belongs_to :trip
  acts_as_votable
end
