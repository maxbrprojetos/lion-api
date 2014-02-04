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

require 'spec_helper'

describe Completion do
  it 'marks the task as completed when created' do
    task = Task.create
    completion = Completion.create(completable: task)

    task.completed.should eq(true)
  end

  it 'marks the task as not completed when destroyed' do
    task = Task.create
    completion = Completion.create(completable: task)
    completion.destroy

    task.completed.should eq(false)
  end
end
