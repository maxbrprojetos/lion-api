module Graph
  Schema = GraphQL::Schema.define do
    query Graph::QueryType
    use GraphQL::Batch
    enable_preloading
  end
end
