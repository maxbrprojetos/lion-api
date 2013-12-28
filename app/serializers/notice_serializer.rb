class NoticeSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :client_id
end
