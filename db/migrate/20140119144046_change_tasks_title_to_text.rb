class ChangeTasksTitleToText < ActiveRecord::Migration
  def up
    change_column :tasks, :title, :text
  end

  def down
    change_column :tasks, :title, :string
  end
end
