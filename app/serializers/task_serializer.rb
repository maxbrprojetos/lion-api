class TaskSerializer < ActiveModel::Serializer
  include PusherableSerializer

  embed :ids, include: true

  attributes :id, :title, :created_at, :completed, :assignee_id

  has_one :user
end
