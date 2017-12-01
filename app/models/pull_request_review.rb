class PullRequestReview < ApplicationRecord
  belongs_to :user
  belongs_to :pull_request

  validates :state, presence: true
  validates :pull_request, presence: true
  validates :user, presence: true

  APPROVAL_STATE = "APPROVED"

  def approval?
    state == APPROVAL_STATE
  end
end
