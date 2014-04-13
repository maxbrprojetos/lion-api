require 'spec_helper'

describe 'Stats Requests' do
  describe 'GET /stats' do
    it 'responds with a json representing the list of users including statistics' do
      users = create_list(:user, 2)
      users = users << current_user

      get api_stats_path

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['stats']).to match_array(
        users.map do |user|
          user = StatsSerializer.new(user)

          {
            'id' => user.id,
            'nickname' => user.nickname,
            'avatar_url' => user.avatar_url,
            'pull_requests_count' => user.pull_requests_count,
            'number_of_additions' => user.number_of_additions,
            'number_of_deletions' => user.number_of_deletions,
            'pull_request_reviews_count' => user.pull_request_reviews_count,
            'tasks_count' => user.tasks_count
          }
        end
      )
    end
  end
end
