class CreateOtherLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :other_locations do |t|
      t.string :category
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :upvote_score
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
