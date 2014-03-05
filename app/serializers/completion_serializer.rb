class CompletionSerializer < ActiveModel::Serializer
  attributes :user_id

  has_one :completable, polymorphic: true
end
