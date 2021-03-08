class AddFakePhotoKeyToMegaliths < ActiveRecord::Migration[6.0]
  def change
    add_column :megaliths, :fake_photo_key, :string
  end
end
