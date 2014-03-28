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

    expect(task.completed).to eq(true)
  end

  it 'marks the task as not completed when destroyed' do
    task_completion = TaskCompletion.create(task: task, user: user)
    task_completion.destroy

    expect(task.completed).to eq(false)
  end

  it 'adds points to the user' do
    task_completion = TaskCompletion.create(task: task, user: user)

    score = Score.first
    expect(score.user).to eq(task_completion.user)
    expect(score.points).to eq(task_completion.points)
  end

  it 'removes points from the user' do
    task_completion = TaskCompletion.create(task: task, user: user)
    task_completion.destroy

    expect(Score.first.points).to eq(0)
  end
end
