class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :duration
      t.string :tagline
      t.string :top_tip
      t.text :description
      t.date :date_visited
      t.integer :upvote_score

      t.timestamps
    end
  end
end
