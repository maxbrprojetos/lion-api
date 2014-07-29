class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.uuid :user_id
      t.uuid :pull_request_id
      t.text :body

      t.timestamps
    end
  end
end
