class AddDefaultValueToNoticesType < ActiveRecord::Migration
  def up
    change_column :notices, :type, :string, default: 'warning'
  end

  def down
    change_column :notices, :type, :string, default: nil
  end
end
