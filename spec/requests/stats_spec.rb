require 'spec_helper'

describe 'Stats Requests', type: :request do
  describe 'GET /stats' do
    it 'responds with a json representing the list of users including statistics' do
      users = create_list(:user, 2)
      users = users << current_user

      review_counts = users.each_with_object(Hash.new) do |user, hash|
        hash[user.id] = rand(100)
      end

      group_double = double(group: double(count: review_counts))
      expect(group_double).to receive(:group).with('user_id')
      expect(PullRequestReview).to receive(:all).and_return(group_double)

      get api_stats_path, category: 'reviews'

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['stats']).to match_array(
        users.map do |user|
          {
            'id' => user.id,
            'nickname' => user.nickname,
            'avatar_url' => user.avatar_url,
            'count' => review_counts[user.id]
          }
        end
      )
    end
  end
end
