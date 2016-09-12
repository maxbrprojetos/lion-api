require 'spec_helper'

describe 'Weekly Winnings graph', type: :request do
  describe 'query weekly_winnings' do
    it 'responds with a json representing the list of weekly winnings' do
      weekly_winnings = create_list(:weekly_winning, 2)

      post api_graph_path(query: <<~QUERY)
        query weekly_winnings {
          weekly_winnings {
            id
            points
            start_date
            winner_id
          }
        }
      QUERY

      expect(JSON.parse(last_response.body)['data']['weekly_winnings']).to match_array(
        weekly_winnings.map do |weekly_winning|
          {
            'id' => weekly_winning.id.to_s,
            'start_date' => weekly_winning.start_date.iso8601,
            'points' => weekly_winning.points,
            'winner_id' => weekly_winning.winner.id.to_s
          }
        end
      )
    end
  end
end
