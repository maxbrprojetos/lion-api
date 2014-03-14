class PullRequestReview < ActiveRecord::Base
  include Scorable

  belongs_to :user
  belongs_to :pull_request

  validates :body, presence: true
  validate :body_must_contain_positive_signs

  def points
    5
  end

  private

  def body_must_contain_positive_signs
    errors.add(:body, 'must contain positive signs') unless body.match(/:\+1:/)
  end
end
