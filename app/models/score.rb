class Score < ApplicationRecord
  belongs_to :user
  belongs_to :pull_request, optional: true
  belongs_to :pull_request_review, optional: true

  validates :user, presence: true
  validates :points, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :pr_xor_review

  scope :by_decreasing_points, -> { order(points: :desc) }
  scope :for_week, ->(date) {
    where(created_at: date.beginning_of_week..date.end_of_week)
  }
  scope :without_pr, -> { where(pull_request_id: nil) }
  scope :without_review, -> { where(pull_request_review_id: nil) }

  def self.weekly_high_score(date = DateTime.now)
    self.weekly_scores(date).to_a.max_by(&:last)
  end

  def self.weekly_scores(date = DateTime.now)
    self.for_week(date).group(:user_id).sum(:points)
  end

  def self.all_time_scores
    group(:user_id).sum(:points)
  end

  private

    def pr_xor_review
      unless pull_request.blank? ^ pull_request_review.blank?
        errors.add(:base, "Specify a pull_request or a pull_request_review, not both")
      end
    end
end
