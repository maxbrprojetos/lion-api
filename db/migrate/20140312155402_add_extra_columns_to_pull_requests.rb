class AddExtraColumnsToPullRequests < ActiveRecord::Migration
  def change
    add_column :pull_requests, :number_of_comments, :integer
    add_column :pull_requests, :number_of_commits, :integer
    add_column :pull_requests, :number_of_additions, :integer
    add_column :pull_requests, :number_of_deletions, :integer
    add_column :pull_requests, :number_of_changed_files, :integer
  end
end
