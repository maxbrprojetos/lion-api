require 'spec_helper'

describe 'Users Requests' do
  describe 'GET /users/me' do
    it 'responds with a json representing the current user' do
      get me_api_users_path

      last_response.status.should eq(200)

      JSON.parse(last_response.body)['user'].should eq(
        'id' => current_user.id,
        'avatar_url' => current_user.avatar_url,
        'nickname' => current_user.nickname,
        'points' => current_user.points
      )
    end
  end

  describe 'GET /users' do
    it 'responds with a json representing the list of registered users' do
      users = create_list(:user, 2)

      get api_users_path

      last_response.status.should eq(200)

      JSON.parse(last_response.body)['users'].should =~
        users.map do |user|
          {
            'id' => user.id,
            'nickname' => user.nickname,
            'avatar_url' => user.avatar_url,
            'points' => user.points
          }
        end.push(
          'id' => current_user.id,
          'nickname' => current_user.nickname,
          'avatar_url' => current_user.avatar_url,
          'points' => current_user.points
        )
    end
  end

  describe 'GET /user/{id}' do
    it 'responds with a json representing the requested user' do
      user = create(:user)

      get api_user_path(user)

      last_response.status.should eq(200)

      JSON.parse(last_response.body)['user'].should eq(
        'id' => user.id,
        'nickname' => user.nickname,
        'avatar_url' => user.avatar_url,
        'points' => current_user.points
      )
    end
  end
end
