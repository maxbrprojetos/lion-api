class AddMergedAtToPullRequests < ActiveRecord::Migration
  def change
    add_column :pull_requests, :merged_at, :datetime
  end
end
