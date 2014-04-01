# == Schema Information
#
# Table name: pull_request_reviews
#
#  id              :integer          not null, primary key
#  user_id         :uuid
#  pull_request_id :uuid
#  body            :text
#  created_at      :datetime
#  updated_at      :datetime
#

class PullRequestReview < ActiveRecord::Base
  include Scorable

  belongs_to :user
  belongs_to :pull_request

  validates :body, presence: true
  validates :pull_request, presence: true
  validates :user, presence: true
  validate :body_must_contain_positive_signs

  def points
    5
  end

  private

  def body_must_contain_positive_signs
    errors.add(:body, 'must contain positive signs') unless body.match(/:\+1:/)
  end

  def scoring_time
    pull_request.merged_at
  end
end
