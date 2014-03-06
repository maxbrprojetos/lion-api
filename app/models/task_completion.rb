# == Schema Information
#
# Table name: task_completions
#
#  id         :uuid             not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :uuid
#  task_id    :uuid
#

class TaskCompletion < ActiveRecord::Base
  POINTS = 5

  belongs_to :task
  belongs_to :user

  after_create :mark_task_as_completed
  after_create :give_points_to_user
  after_destroy :take_points_from_user
  after_destroy :mark_task_as_not_completed

  private

  def mark_task_as_completed
    task.update(completed: true)
  end

  def mark_task_as_not_completed
    task.update(completed: false)
  end

  def give_points_to_user
    user && user.increment_points_by(POINTS)
  end

  def take_points_from_user
    user && user.decrement_points_by(POINTS)
  end
end
