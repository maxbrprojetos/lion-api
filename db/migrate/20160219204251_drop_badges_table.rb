class DropBadgesTable < ActiveRecord::Migration
  def change
    drop_table :badges
  end
end
