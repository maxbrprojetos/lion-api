module Graph
  AuthSchema = GraphQL::Schema.define do
    query Graph::AuthQueryType
    mutation Graph::AuthMutationType
  end
end
