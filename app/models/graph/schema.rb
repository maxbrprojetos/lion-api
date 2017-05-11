module Graph
  Schema = GraphQL::Schema.define do
    query Graph::QueryType
    lazy_resolve(Promise, :sync)
    instrument(:query, GraphQL::Batch::Setup)
  end
end
