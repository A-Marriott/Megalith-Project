class AddMegalithPhotoIdToTripPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :trip_photos, :megalith_photo_id, :string
  end
end
