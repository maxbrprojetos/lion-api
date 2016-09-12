module Graph
  AuthSchema = GraphQL::Schema.new(
    query: Graph::AuthQueryType,
    mutation: Graph::AuthMutationType
  )
end
