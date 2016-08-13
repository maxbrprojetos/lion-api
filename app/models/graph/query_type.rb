module Graph
  QueryType = GraphQL::ObjectType.define do
    name "Query"
    description "The query root of this schema"

    field :weekly_winnings do
      type !types[!Graph::WeeklyWinningType]
      resolve -> (_, _, _) { WeeklyWinning.order(start_date: :desc) }
    end

    field :scores do
      type !types[!Graph::ScoreType]
      argument :time_span, !types.String, "The time span of the scores"
      resolve -> (_, arguments, _) do
        Score.where(time_span: arguments[:time_span]).where("points > ?", 0)
      end
    end

    field :stats do
      type !types[!Graph::StatsType]
      argument :category, !types.String, "The category of the stat"
      resolve -> (_, arguments, _) do
        stats = case arguments[:category]
          when "pull_requests"
            PullRequest.group("user_id").count
          when "reviews"
            PullRequestReview.group("user_id").count
          when "additions"
            PullRequest.group("user_id").sum(:number_of_additions)
          when "deletions"
            PullRequest.group("user_id").sum(:number_of_deletions)
          else []
        end

        stats.map do |key, value|
          OpenStruct.new(
            id: "#{key}-#{arguments[:category]}",
            count: value,
            user_id: key
          )
        end
      end
    end

    field :user do
      type Graph::UserType
      argument :id, !types.ID, "The id of the user"
      resolve -> (_, arguments, context) do
        if arguments[:id] == "me"
          context[:current_user]
        else
          User.find(arguments[:id])
        end
      end
    end

    field :users do
      type !types[!Graph::UserType]
      argument :ids, !types[!types.ID], "The ids of the users"
      resolve -> (_, arguments, _) do
        User.find(arguments[:ids])
      end
    end
  end
end
