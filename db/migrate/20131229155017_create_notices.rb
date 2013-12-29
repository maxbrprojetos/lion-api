class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices, id: :uuid do |t|
      t.text :title
      t.string :type

      t.timestamps
    end
  end
end
