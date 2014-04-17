class WeeklyWinningSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :points

  embed :ids, include: true

  has_one :winner
end
