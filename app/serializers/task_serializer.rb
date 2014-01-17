class TaskSerializer < ActiveModel::Serializer
  include PusherableSerializer

  embed :ids, include: true

  attributes :id, :title, :created_at, :completed

  has_one :user
end
