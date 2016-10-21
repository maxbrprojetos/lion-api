module Graph
  Schema = GraphQL::Schema.new(query: Graph::QueryType)
end

Graph::Schema.query_execution_strategy = GraphQL::Batch::ExecutionStrategy
