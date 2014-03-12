class DropTablePullRequestMergers < ActiveRecord::Migration
  def change
    drop_table :pull_request_mergers
  end
end
