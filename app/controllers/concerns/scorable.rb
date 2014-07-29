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
    Score.give(time: scoring_time, user: points_recipient, points: points)
  end

  def take_points_from_user
    Score.take(user: user, points: points)
  end

  def scoring_time
    created_at
  end
end
