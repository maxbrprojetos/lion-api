module Graph
  StatsType = GraphQL::ObjectType.define do
    name "Stats"
    description "A representation of a user's performance in a given category"

    field :count, types.Int
    field :id, types.ID
    field :user_id, types.ID
    field :user, Graph::UserType
  end
end
