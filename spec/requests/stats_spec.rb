require 'spec_helper'

describe 'Stats graph', type: :request do
  describe 'query stats' do
    it 'responds with a list of statistics for each user' do
      users = create_list(:user, 2)
      users = users << current_user

      review_counts = users.each_with_object(Hash.new) do |user, hash|
        hash[user.id] = rand(100)
      end

      group_double = double(:group, count: review_counts)
      expect(PullRequestReview).to receive(:group)
        .with(:user_id).and_return(group_double)

      post api_graph_path(query: <<~QUERY)
        query stats {
          stats(category: "reviews") {
            id
            count
            user_id
          }
        }
      QUERY

      expect(JSON.parse(last_response.body)['data']['stats']).to match_array(
        users.map do |user|
          {
            'id' => "#{user.id}-reviews",
            'count' => review_counts[user.id],
            'user_id' => user.id.to_s
          }
        end
      )
    end
  end
end
