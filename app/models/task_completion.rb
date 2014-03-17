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
  include Scorable

  belongs_to :task
  belongs_to :user

  validates :user, presence: true
  validates :task, presence: true

  after_create :mark_task_as_completed
  after_destroy :mark_task_as_not_completed

  def points
    1
  end

  private

  def mark_task_as_completed
    task.update(completed: true)
  end

  def mark_task_as_not_completed
    task.update(completed: false)
  end
end
