class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :avatar_url
      t.string :api_token
      t.string :github_id

      t.timestamps
    end
  end
end
