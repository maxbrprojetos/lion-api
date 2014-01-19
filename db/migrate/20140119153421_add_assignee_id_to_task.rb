class AddAssigneeIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :assignee_id, :uuid
  end
end
