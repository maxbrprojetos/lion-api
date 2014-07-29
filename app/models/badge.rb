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

  TROPHY = ':trophy:'
  DANCER = ':dancer:'
  STAR = ':star:'
  ONE_HUNDRED = ':100:'

  private

  def points_recipient
    pull_request.user
  end

  def points
    if one_hundred?
      20
    elsif trophy?
      10
    elsif dancer? || star?
      5
    else
      0
    end
  end

  def badge_patterns
    [TROPHY, DANCER, STAR, ONE_HUNDRED].join('|')
  end

  def body_must_contain_badges
    errors.add(:body, 'must contain a special badge') unless body.match(badge_patterns)
  end

  def scoring_time
    pull_request.merged_at
  end

  def trophy?
    body.match(/:trophy:/).present?
  end

  def one_hundred?
    body.match(/:100:/).present?
  end

  def star?
    body.match(/:star:/).present?
  end

  def dancer?
    body.match(/:dancer:/).present?
  end
end
