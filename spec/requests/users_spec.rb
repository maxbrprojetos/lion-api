require 'spec_helper'

describe 'Users graph', type: :request do
  describe 'query user' do
    context 'with id "me"' do
      it 'responds with a json representing the current user' do
        post api_graph_path(query: <<~QUERY)
          query user {
            user(id: "me") {
              id
              avatar_url
              nickname
            }
          }
        QUERY

        expect(JSON.parse(last_response.body)['data']['user']).to eq(
          'id' => current_user.id,
          'avatar_url' => current_user.avatar_url,
          'nickname' => current_user.nickname
        )
      end
    end

    context 'with a regular id' do
      it 'responds with a json representing the requested user' do
        user = create(:user)

        post api_graph_path(query: <<~QUERY)
          query user {
            user(id: "#{user.id}") {
              id
              avatar_url
              nickname
            }
          }
        QUERY

        expect(JSON.parse(last_response.body)['data']['user']).to eq(
          'id' => user.id,
          'nickname' => user.nickname,
          'avatar_url' => user.avatar_url
        )
      end
    end
  end

  describe 'query users' do
    it 'responds with a json representing the list of registered users' do
      users = create_list(:user, 2)

      post api_graph_path(query: <<~QUERY)
        query users {
          users(ids: #{users.map(&:id)}) {
            id
            avatar_url
            nickname
          }
        }
      QUERY

      expect(JSON.parse(last_response.body)['data']['users']).to match_array(
        [{
          'id' => users.first.id,
          'nickname' => users.first.nickname,
          'avatar_url' => users.first.avatar_url
        }, {
          'id' => users.last.id,
          'nickname' => users.last.nickname,
          'avatar_url' => users.last.avatar_url
        }]
      )
    end
  end
end
