class NoticeSerializer < ActiveModel::Serializer
  include PusherableSerializer

  attributes :id, :title, :created_at, :type, :app
end
