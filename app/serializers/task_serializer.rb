class TaskSerializer < ActiveModel::Serializer
  include PusherableSerializer

  attributes :id, :title, :created_at
end
