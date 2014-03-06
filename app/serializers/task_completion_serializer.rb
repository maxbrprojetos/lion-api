class TaskCompletionSerializer < ActiveModel::Serializer
  has_one :user
  has_one :task
end
