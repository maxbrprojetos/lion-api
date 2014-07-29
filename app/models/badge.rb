# == Schema Information
#
# Table name: badges
#
#  id              :integer          not null, primary key
#  user_id         :uuid
#  pull_request_id :uuid
#  body            :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Badge < ActiveRecord::Base
  include Scorable

  belongs_to :user
  belongs_to :pull_request

  validates :body, presence: true
  validates :pull_request, presence: true
  validates :user, presence: true
  validate :body_must_contain_badges

  def points
    (pull_request.points / 2).round
  end

  private

  def body_must_contain_badges
    errors.add(:body, 'must contain badges') unless body.match(/:100:|:trophy:|:star:/)
  end

  def scoring_time
    pull_request.merged_at
  end
end
