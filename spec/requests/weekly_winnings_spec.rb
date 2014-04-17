require 'spec_helper'

describe 'Weekly Winnings Requests' do
  describe 'GET /weekly_winnings' do
    it 'responds with a json representing the list of weekly winnings' do
      weekly_winnings = create_list(:weekly_winning, 2)

      get api_weekly_winnings_path

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['weekly_winnings']).to match_array(
        weekly_winnings.map do |weekly_winning|
          {
            'id' => weekly_winning.id,
            'winner_id' => weekly_winning.winner.id,
            'start_date' => weekly_winning.start_date.iso8601,
            'points' => weekly_winning.points
          }
        end
      )

      expect(JSON.parse(last_response.body)['winners']).to match_array(
        weekly_winnings.map do |weekly_winning|
          {
            'id' => weekly_winning.winner.id,
            'avatar_url' => weekly_winning.winner.avatar_url,
            'nickname' => weekly_winning.winner.nickname
          }
        end
      )
    end
  end
end
