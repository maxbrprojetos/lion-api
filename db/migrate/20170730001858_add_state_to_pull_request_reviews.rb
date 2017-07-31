class AddStateToPullRequestReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :pull_request_reviews, :state, :string
  end
end
