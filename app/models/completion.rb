class Completion < ActiveRecord::Base
  POINTS = 5

  belongs_to :completable, polymorphic: true

  after_create :mark_completable_as_completed
  after_destroy :mark_completable_as_not_completed

  private

  def mark_completable_as_completed
    completable.update_column(:completed, true)
  end

  def mark_completable_as_not_completed
    completable.update_column(:completed, false)
  end
end
