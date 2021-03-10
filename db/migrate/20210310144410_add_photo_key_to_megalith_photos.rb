class AddPhotoKeyToMegalithPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :megalith_photos, :photo_key, :string
  end
end
