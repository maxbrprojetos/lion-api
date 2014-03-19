class RemovePointsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :points, :integer
  end
end
