class CreateWeeklyWinnings < ActiveRecord::Migration
  def change
    create_table :weekly_winnings, id: :uuid do |t|
      t.uuid :winner_id
      t.date :start_date
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
