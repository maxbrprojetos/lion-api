class ChangePullRequestBodyToText < ActiveRecord::Migration
  def up
    change_column :pull_requests, :body, :text
  end

  def down
    change_column :pull_requests, :body, :string
  end
end
