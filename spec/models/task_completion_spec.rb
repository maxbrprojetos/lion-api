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

require 'spec_helper'

describe TaskCompletion do
  it 'marks the task as completed when created' do
    task = Task.create
    TaskCompletion.create(task: task)

    task.completed.should eq(true)
  end

  it 'marks the task as not completed when destroyed' do
    task = Task.create
    task_completion = TaskCompletion.create(task: task)
    task_completion.destroy

    task.completed.should eq(false)
  end
end
