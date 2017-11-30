module Graph
  ScoreType = GraphQL::ObjectType.define do
    name "Score"
    description "A representation of a user's score"

    field :id, types.ID
    field :points, types.Int
    field :user, Graph::UserType, preload: :user
  end
end
