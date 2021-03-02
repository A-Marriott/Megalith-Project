class CreateMegaliths < ActiveRecord::Migration[6.0]
  def change
    create_table :megaliths do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :category
      t.string :tagline
      t.text :description
      t.float :average_rating

      t.timestamps
    end
  end
end
