class Task < ActiveRecord::Base
  include Pusherable

  pusherable serializer: TaskSerializer

  belongs_to :user
  belongs_to :assignee, class_name: 'User'
  has_one :completion, as: :completable
end
