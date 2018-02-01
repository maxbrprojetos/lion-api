class AddTitleToPullRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :pull_requests, :title, :string
  end
end
