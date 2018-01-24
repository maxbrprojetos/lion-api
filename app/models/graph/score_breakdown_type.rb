module Graph
  ScoreBreakdownType = GraphQL::ObjectType.define do
    name "ScoreBreakdown"
    description "A representation of the breakdown of a user's score"

    field :created_at, types.String
    field :id, types.ID
    field :points, types.Int
    field :user, Graph::UserType, preload: :user

    field :pull_request, Graph::PullRequestType do
      preload :pull_request, pull_request_review: :pull_request
      resolve -> (score, _, _) do
        score.pull_request || score.pull_request_review.pull_request
      end
    end

    field :review, types.Boolean do
      preload :pull_request_review
      resolve -> (score, _, _) { score.pull_request_review.present? }
    end
  end
end
