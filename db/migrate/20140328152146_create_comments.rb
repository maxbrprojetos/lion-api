class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, id: :uuid do |t|
      t.text :body
      t.uuid :user_id
      t.uuid :task_id

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :task_id
  end
end
