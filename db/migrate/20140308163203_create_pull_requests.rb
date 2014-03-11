class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.json :data
      t.string :repo_full_name
      t.integer :number
      t.uuid :user_id

      t.timestamps
    end
  end
end
