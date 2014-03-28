class CommentSerializer < ActiveModel::Serializer
  include PusherableSerializer

  attributes :id, :body, :created_at, :task_id, :user_id
end
