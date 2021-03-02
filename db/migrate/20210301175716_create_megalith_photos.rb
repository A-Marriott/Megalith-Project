class CreateMegalithPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :megalith_photos do |t|
      t.integer :upvote_score
      t.references :user, null: false, foreign_key: true
      t.references :megalith, null: false, foreign_key: true

      t.timestamps
    end
  end
end
