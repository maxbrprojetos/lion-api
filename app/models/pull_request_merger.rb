# == Schema Information
#
# Table name: pull_request_mergers
#
#  id           :uuid             not null, primary key
#  pull_request :hstore
#  user_id      :uuid
#  created_at   :datetime
#  updated_at   :datetime
#

class PullRequestMerger < ActiveRecord::Base
  include Scorable

  belongs_to :user

  validates :user, presence: true
  validates :pull_request, presence: true

  validate :must_be_merged

  def pull_request=(pull_request)
    self.user = User.where(nickname: pull_request[:user][:login]).first
    super
  end

  private

  def must_be_merged
    errors.add(:pull_request, 'must be merged') unless pull_request['merged'] == 'true'
  end

  def self.points
    15
  end
end
