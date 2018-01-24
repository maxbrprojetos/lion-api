module Graph
  PullRequestType = GraphQL::ObjectType.define do
    name "PullRequest"
    description "A representation of a PullRequest"

    field :additions, types.Int, property: :number_of_additions
    field :deletions, types.Int, property: :number_of_deletions
    field :id, types.ID
    field :name, types.String, property: :base_repo_full_name
    field :number, types.Int
    field :user, Graph::UserType, preload: :user
  end
end
