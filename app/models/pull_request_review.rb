class PullRequestReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :pull_request

  validates :body, presence: true
  validates :pull_request, presence: true
  validates :user, presence: true
  validate :body_must_contain_positive_signs

  private

  def body_must_contain_positive_signs
    unless body.match(/:\+1:|:thumbsup:|:shipit:/)
      errors.add(:body, 'must contain positive signs')
    end
  end
end
