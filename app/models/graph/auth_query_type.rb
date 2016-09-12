module Graph
  AuthQueryType = GraphQL::ObjectType.define do
    name "AuthQuery"
    description "The query root of this schema"

    field :token do
      type Graph::TokenType
      argument :id, !types.ID, "The id of the token"
      resolve -> (object, arguments, context) do
        AccessToken.find(arguments[:id])
      end
    end
  end
end
