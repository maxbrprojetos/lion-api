class WeeklyWinning < ApplicationRecord
  belongs_to :winner, class_name: 'User'

  validates :winner, presence: true
  validates :start_date, presence: true
  validate :one_winning_per_week

  def one_winning_per_week
    beginning_of_week = Time.now.beginning_of_week
    end_of_week = Time.now.end_of_week
    errors.add(:start_date, 'has already been taken') if WeeklyWinning.where(start_date: (beginning_of_week..end_of_week)).first.present?
  end
end
