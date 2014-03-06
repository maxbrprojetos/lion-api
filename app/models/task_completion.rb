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
  after_destroy :mark_task_as_not_completed

  private

  def mark_task_as_completed
    task.update(completed: true)
  end

  def mark_task_as_not_completed
    task.update(completed: false)
  end
end
