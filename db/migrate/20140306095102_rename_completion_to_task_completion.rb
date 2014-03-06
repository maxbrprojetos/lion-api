class RenameCompletionToTaskCompletion < ActiveRecord::Migration
  def change
    rename_table :completions, :task_completions
    add_column :task_completions, :task_id, :uuid
    TaskCompletion.update_all 'task_id=completable_id'
    remove_column :task_completions, :completable_type
    remove_column :task_completions, :completable_id
  end
end
