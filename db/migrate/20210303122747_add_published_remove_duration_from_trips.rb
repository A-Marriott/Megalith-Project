class AddPublishedRemoveDurationFromTrips < ActiveRecord::Migration[6.0]
  def change
    change_table :trips do |t|
      t.remove :duration
      t.boolean :published
    end
  end
end
