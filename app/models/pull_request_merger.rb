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

  belongs_to :pull_request

  private

  def self.points
    15
  end
end
