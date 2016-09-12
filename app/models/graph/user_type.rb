module Graph
  UserType = GraphQL::ObjectType.define do
    name "User"
    description "A user object"

    field :avatar_url, types.String
    field :id, types.ID
    field :name, types.String
    field :nickname, types.String
  end
end
