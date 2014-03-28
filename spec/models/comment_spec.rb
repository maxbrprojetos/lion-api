# == Schema Information
#
# Table name: comments
#
#  id         :uuid             not null, primary key
#  body       :text
#  user_id    :uuid
#  task_id    :uuid
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_comments_on_task_id  (task_id)
#  index_comments_on_user_id  (user_id)
#

require 'spec_helper'

describe Comment do
  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end
end
