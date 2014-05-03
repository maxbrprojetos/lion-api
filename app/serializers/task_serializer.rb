class TaskSerializer < ActiveModel::Serializer
  include PushableSerializer

  embed :ids, include: true

  attributes :id, :title, :created_at, :completed, :assignee_id

  has_one :user
  has_many :comments
end
