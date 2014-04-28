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

class Comment < ActiveRecord::Base
  include Pusherable

  belongs_to :user
  belongs_to :task, touch: true

  validates :body, presence: true
  validates :user, presence: true
  validates :task, presence: true
end
