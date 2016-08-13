module Graph
  TokenType = GraphQL::ObjectType.define do
    name "Token"
    description "An access token object"

    field :access_token, types.String
    field :expires_in, types.Int
    field :id, types.ID
    field :user_id, types.ID

    field :code do
      type types.String
      resolve -> (_, _, _) { nil }
    end
  end
end
