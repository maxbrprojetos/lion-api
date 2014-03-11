class NormalizePullRequestMergers < ActiveRecord::Migration
  def change
    remove_column :pull_request_mergers, :user_id, :uuid
    remove_column :pull_request_mergers, :pull_request, :hstore
  end
end
