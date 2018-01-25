require 'spec_helper'

describe 'Scores graph', type: :request do
  describe 'query scores' do
    it 'responds with a json representing the list of users with their scores' do
      jay = create(:user, name: 'Jay')
      joe = create(:user, name: 'Joe')
      jay_score = create(:score, :previous_week, user: jay, points: 10)
      joe_score = create(:score, :previous_week, user: joe, points: 5)

      post api_graph_path(query: <<~QUERY)
        query scores {
          scores(time_span: "all_time") {
            id
            points
            user {
              id
            }
          }
        }
      QUERY

      expect(JSON.parse(last_response.body)['data']['scores']).to match_array(
        [{
          'id' => "#{jay.id}-all_time",
          'points' => 10,
          'user' => {
            'id' => jay.id.to_s
          }
        }, {
          'id' => "#{joe.id}-all_time",
          'points' => 5,
          'user' => {
            'id' => joe.id.to_s
          }
        }]
      )
    end
  end
end
