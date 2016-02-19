class Pairing < ActiveRecord::Base
  include Scorable

  belongs_to :user
  belongs_to :pull_request

  validates :pull_request, presence: true
  validates :user, presence: true

  def points
    (pull_request.points / pull_request.pairings.count).round
  end

  private

  def scoring_time
    pull_request.merged_at
  end
end
