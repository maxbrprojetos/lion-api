class AddUniqueIndexToPullRequests < ActiveRecord::Migration[5.0]
  def change
    add_index :pull_requests, [:base_repo_full_name, :number], unique: true
  end
end
