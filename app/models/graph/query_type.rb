module Graph
  QueryType = GraphQL::ObjectType.define do
    name "Query"
    description "The query root of this schema"

    field :weekly_winnings, types[Graph::WeeklyWinningType] do
      resolve -> (_, _, _) { WeeklyWinning.order(start_date: :desc) }
    end

    field :score_breakdowns, types[Graph::ScoreBreakdownType] do
      argument :week, !types.Int, "The week for which we want a score breakdown (how many weeks ago)"
      argument :user_id, !types.ID, "The user whose breakdown is being requested"
      resolve ->(_, arguments, _) do
        week = DateTime.now.weeks_ago(arguments[:week])
        Score.for_week(week).where(user_id: arguments[:user_id])
      end
    end

    field :scores, types[Graph::ScoreType] do
      argument :time_span, !types.String, "The time span of the scores"
      resolve -> (_, arguments, _) do
        scores = case arguments[:time_span]
          when "all_time"
            Score.all_time_scores
          when "weekly"
            Score.weekly_scores
          else []
        end

        users = User.where(id: scores.map(&:first))
        scores.map do |user_id, points|
          OpenStruct.new(
            id: "#{user_id}-#{arguments[:time_span]}",
            points: points,
            user: users.find { |u| u.id == user_id }
          )
        end
      end
    end

    field :stats, types[Graph::StatsType] do
      argument :category, !types.String, "The category of the stat"
      resolve -> (_, arguments, _) do
        stats = case arguments[:category]
          when "pull_requests"
            PullRequest.group(:user_id).count
          when "reviews"
            PullRequestReview.group(:user_id).count
          when "additions"
            PullRequest.group(:user_id).sum(:number_of_additions)
          when "deletions"
            PullRequest.group(:user_id).sum(:number_of_deletions)
          else []
        end

        users = User.where(id: stats.map(&:first))
        stats.map do |user_id, count|
          OpenStruct.new(
            id: "#{user_id}-#{arguments[:category]}",
            count: count,
            user: users.find { |u| u.id == user_id }
          )
        end
      end
    end

    field :user, Graph::UserType do
      argument :id, !types.ID, "The id of the user"
      resolve -> (_, arguments, context) do
        if arguments[:id] == "me"
          context[:current_user]
        else
          User.find(arguments[:id])
        end
      end
    end

    field :users, types[Graph::UserType] do
      argument :ids, !types[!types.ID], "The ids of the users"
      resolve -> (_, arguments, _) do
        User.where(id: arguments[:ids])
      end
    end
  end
end
