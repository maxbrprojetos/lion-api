class AddUserIdToCompletion < ActiveRecord::Migration
  def change
    add_column :completions, :user_id, :uuid
  end
end
