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
  let(:task) { create(:task) }
  let(:user) { create(:user) }

  it 'marks the task as completed when created' do
    TaskCompletion.create(task: task, user: user)

    task.completed.should eq(true)
  end

  it 'marks the task as not completed when destroyed' do
    task_completion = TaskCompletion.create(task: task, user: user)
    task_completion.destroy

    task.completed.should eq(false)
  end

  it 'adds points to the user' do
    task_completion = TaskCompletion.create(task: task, user: user)

    user.points.should eq(task_completion.points)
  end

  it 'removes points from the user' do
    task_completion = TaskCompletion.create(task: task, user: user)
    task_completion.destroy

    user.points.should eq(0)
  end
end
