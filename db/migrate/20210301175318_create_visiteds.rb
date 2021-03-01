class CreateVisiteds < ActiveRecord::Migration[6.0]
  def change
    create_table :visiteds do |t|
      t.references :megalith, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
