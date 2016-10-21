module Graph
  ScoreType = GraphQL::ObjectType.define do
    name "Score"
    description "A representation of a user's score"

    field :id, types.ID
    field :points, types.Int
    field :user, Graph::UserType do
      resolve -> (score, _, _) do
        Loaders::FindLoader.for(User, :id).load(score.user_id)
      end
    end
  end
end
