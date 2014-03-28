require 'spec_helper'

describe 'Users Requests' do
  describe 'GET /users/me' do
    it 'responds with a json representing the current user' do
      get me_api_users_path

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['user']).to eq(
        'id' => current_user.id,
        'avatar_url' => current_user.avatar_url,
        'nickname' => current_user.nickname
      )
    end
  end

  describe 'GET /users' do
    it 'responds with a json representing the list of registered users' do
      users = create_list(:user, 2)

      get api_users_path

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['users']).to match_array(
        users.map do |user|
          {
            'id' => user.id,
            'nickname' => user.nickname,
            'avatar_url' => user.avatar_url
          }
        end.push(
          'id' => current_user.id,
          'nickname' => current_user.nickname,
          'avatar_url' => current_user.avatar_url
        )
      )
    end
  end

  describe 'GET /user/{id}' do
    it 'responds with a json representing the requested user' do
      user = create(:user)

      get api_user_path(user)

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['user']).to eq(
        'id' => user.id,
        'nickname' => user.nickname,
        'avatar_url' => user.avatar_url
      )
    end
  end
end
