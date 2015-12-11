class DropTaskCompletions < ActiveRecord::Migration
  def change
    drop_table :task_completions
  end
end
