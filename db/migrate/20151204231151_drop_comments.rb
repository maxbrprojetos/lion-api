class DropComments < ActiveRecord::Migration
  def change
    remove_index :comments, :task_id
    remove_index :comments, :user_id
    drop_table :comments
  end
end
