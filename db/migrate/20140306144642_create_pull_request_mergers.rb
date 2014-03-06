class CreatePullRequestMergers < ActiveRecord::Migration
  def change
    create_table :pull_request_mergers, id: :uuid do |t|
      t.hstore :pull_request
      t.uuid :user_id

      t.timestamps
    end
  end
end
