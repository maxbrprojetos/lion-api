# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  title       :text
#  completed   :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :uuid
#  assignee_id :uuid
#

class Task < ActiveRecord::Base
  include Pusherable

  belongs_to :user
  belongs_to :assignee, class_name: 'User'
  has_many :comments
  has_one :task_completion

  validates :title, presence: true
  validates :user, presence: true
end
