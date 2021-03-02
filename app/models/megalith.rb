class Megalith < ApplicationRecord
  has_many :megalith_photos, dependent: :destroy
end
