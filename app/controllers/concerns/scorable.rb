module Scorable
  extend ActiveSupport::Concern

  included do
    after_create :give_points_to_user
    after_destroy :take_points_from_user
  end

  private

  def points_recipient
    user
  end

  def give_points_to_user
    if self.kind_of?(Badge)
      pull_request.pairings.each do |recipient|
        each_point = (points / pull_request.pairings.count).round
        Score.give(time: scoring_time, user: recipient.user, points: each_point)
      end
    else
      Score.give(time: scoring_time, user: points_recipient, points: points)
    end
  end

  def take_points_from_user
    Score.take(user: user, points: points)
  end

  def scoring_time
    created_at
  end
end
