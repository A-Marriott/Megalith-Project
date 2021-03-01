class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :upvotes
      t.references :user, null: false, foreign_key: true
      t.references :megalith, null: false, foreign_key: true

      t.timestamps
    end
  end
end
