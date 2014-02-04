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

  pusherable serializer: TaskSerializer

  belongs_to :user
  belongs_to :assignee, class_name: 'User'
  has_one :completion, as: :completable
end
