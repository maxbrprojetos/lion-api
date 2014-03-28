require 'spec_helper'

describe 'Scores Requests' do
  describe 'GET /scores?time_span=all-time' do
    it 'responds with a json representing the list of users with their scores' do
      users = create_list(:user, 2)
      joe_score = Score.create!(user: users[0], points: 10)
      matteo_score = Score.create!(user: users[1], points: 5)

      get api_scores_path(time_span: 'all_time')

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['users']).to match_array(
        users.map do |user|
          {
            'id' => user.id,
            'nickname' => user.nickname,
            'avatar_url' => user.avatar_url
          }
        end
      )

      expect(JSON.parse(last_response.body)['scores']).to match_array(
        [
          {
            'id' => joe_score.id,
            'user_id' => joe_score.user_id,
            'points' => joe_score.points
          },
          {
            'id' => matteo_score.id,
            'user_id' => matteo_score.user_id,
            'points' => matteo_score.points
          }
        ]
      )
    end
  end
end
