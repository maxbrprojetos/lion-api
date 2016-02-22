class AddBodyToPullRequest < ActiveRecord::Migration
  def change
    add_column :pull_requests, :body, :string
  end
end
