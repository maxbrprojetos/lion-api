class AddPrAndReviewReferencesToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :pull_request_id, :uuid
    add_index :scores, :pull_request_id
    add_foreign_key :scores, :pull_requests

    add_reference :scores, :pull_request_review, foreign_key: true
  end
end
