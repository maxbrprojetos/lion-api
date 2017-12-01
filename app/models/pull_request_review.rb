class PullRequestReview < ApplicationRecord
  belongs_to :user
  belongs_to :pull_request

  has_many :scores

  scope :approved, -> { where(state: APPROVAL_STATE) }
  scope :missing_scores, -> {
    approved.left_joins(:scores).where(scores: { pull_request_review_id: nil })
  }

  validates :state, presence: true
  validates :pull_request, presence: true
  validates :user, presence: true

  APPROVAL_STATE = "APPROVED"

  def approval?
    state == APPROVAL_STATE
  end
end
