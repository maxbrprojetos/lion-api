require 'spec_helper'

describe 'Scores graph', type: :request do
  describe 'query scores' do
    it 'responds with a json representing the list of users with their scores' do
      users = create_list(:user, 2)
      joe_score = Score.create!(user: users[0], points: 10)
      matteo_score = Score.create!(user: users[1], points: 5)

      post api_graph_path(query: <<~QUERY)
        query scores {
          scores(time_span: "all_time") {
            id
            points
            user {
              id
              avatar_url
              nickname
            }
          }
        }
      QUERY

      expect(JSON.parse(last_response.body)['data']['scores']).to match_array(
        [{
          'id' => joe_score.id.to_s,
          'points' => 10,
          'user' => {
            'id' => users[0].id.to_s,
            'avatar_url' => users[0].avatar_url,
            'nickname' => users[0].nickname
          }
        }, {
          'id' => matteo_score.id.to_s,
          'points' => 5,
          'user' => {
            'id' => users[1].id.to_s,
            'avatar_url' => users[1].avatar_url,
            'nickname' => users[1].nickname
          }
        }]
      )
    end
  end
end
