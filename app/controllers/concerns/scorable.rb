module Scorable
  extend ActiveSupport::Concern

  included do
    after_create :give_points_to_user
    after_destroy :take_points_from_user
  end

  private

  def give_points_to_user
    user && user.increment_points_by(self.class.points)
  end

  def take_points_from_user
    user && user.decrement_points_by(self.class.points)
  end
end
