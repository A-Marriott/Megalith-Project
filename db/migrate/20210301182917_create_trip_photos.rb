class CreateTripPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_photos do |t|
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
