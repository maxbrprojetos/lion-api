class AddAppToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :app, :string
  end
end
