class CreateTripMegaliths < ActiveRecord::Migration[6.0]
  def change
    create_table :trip_megaliths do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :megalith, null: false, foreign_key: true
      t.boolean :main

      t.timestamps
    end
  end
end
