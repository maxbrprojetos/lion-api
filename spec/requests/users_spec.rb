require 'spec_helper'

describe 'Users Requests' do
  describe 'GET /users/me' do
    it 'responds with a json representing the current user' do
      get me_api_users_path

      last_response.status.should eq(200)

      JSON.parse(last_response.body)['user'].should eq({
        'id' => @user.id,
        'avatar_url' => @user.avatar_url,
        'nickname' => @user.nickname
      })
    end
  end
end