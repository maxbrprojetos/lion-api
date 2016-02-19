class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings, id: :uuid, default: "uuid_generate_v4()", force: true do |t|
      t.uuid :user_id
      t.uuid :pull_request_id

      t.timestamps
    end
  end
end
