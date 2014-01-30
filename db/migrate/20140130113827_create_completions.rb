class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions, id: :uuid do |t|
      t.uuid :completable_id
      t.string :completable_type

      t.timestamps
    end
  end
end
