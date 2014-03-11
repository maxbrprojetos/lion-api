class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests, id: :uuid do |t|
      t.string :base_repo_full_name
      t.integer :number
      t.uuid :user_id

      t.timestamps
    end
  end
end
