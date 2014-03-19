class ScoreSerializer < ActiveModel::Serializer
  attributes :id, :points

  embed :ids, include: true

  has_one :user
end
