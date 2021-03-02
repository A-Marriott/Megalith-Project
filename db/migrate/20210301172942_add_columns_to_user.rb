class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :overall_rating, :integer
    add_column :users, :photographer_score, :integer
    add_column :users, :commenter_score, :integer
    add_column :users, :tour_guide_score, :integer
  end
end
