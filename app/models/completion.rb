# == Schema Information
#
# Table name: completions
#
#  id               :uuid             not null, primary key
#  completable_id   :uuid
#  completable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class Completion < ActiveRecord::Base
  POINTS = 5

  belongs_to :completable, polymorphic: true

  after_create :mark_completable_as_completed
  after_destroy :mark_completable_as_not_completed

  private

  def mark_completable_as_completed
    completable.update(completed: true)
  end

  def mark_completable_as_not_completed
    completable.update(completed: false)
  end
end
