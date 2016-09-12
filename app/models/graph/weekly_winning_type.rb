module Graph
  WeeklyWinningType = GraphQL::ObjectType.define do
    name "WeeklyWinning"
    description "A representation of each weekly winner in the hall of fame"

    field :id, types.ID
    field :points, types.Int
    field :start_date, types.String
    field :winner_id, types.ID
  end
end
