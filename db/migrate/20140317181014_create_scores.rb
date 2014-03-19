class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores, id: :uuid do |t|
      t.uuid :user_id
      t.integer :points, default: 0
      t.string :time_span, default: 'all_time'

      t.timestamps
    end
  end
end
