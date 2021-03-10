class MegalithPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :megalith
  has_one_attached :photo
  acts_as_votable
  before_destroy :remove_foreign_key_from_trip_photo

  private
  def remove_foreign_key_from_trip_photo
    if photo_key
      trip_photo = TripPhoto.where(megalith_photo_id: self.id).first
      trip_photo.update(megalith_photo_id: nil)
    end
  end
end
