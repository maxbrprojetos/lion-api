class CommentSerializer < ActiveModel::Serializer
  include PushableSerializer

  attributes :id, :body, :created_at, :task_id, :user_id
end
