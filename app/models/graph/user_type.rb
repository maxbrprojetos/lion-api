module Graph
  UserType = GraphQL::ObjectType.define do
    name "User"
    description "A user object"

    field :avatar_url, types.String
    field :id, types.ID
    field :name, types.String
    field :nickname, types.String

    field :score_breakdowns, types[Graph::ScoreBreakdownType] do
      argument :week, !types.Int, "The week for which we want a score breakdown (how many weeks ago)"

      resolve ->(user, args, _) do
        week = DateTime.now.weeks_ago(args[:week])
        Score.for_week(week).where(user_id: user.id)
      end
    end
  end
end
