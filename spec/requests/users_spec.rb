require 'spec_helper'

describe 'Users Requests' do
  include Rack::Test::Methods

  before do
    @user = User.create(api_token: 'test', nickname: 'lol', avatar_url: 'omg')
    header 'Authorization', "Bearer #{@user.api_token}"
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
  end

  describe 'GET /me' do
    it 'responds with a json representing the current user' do
      get me_api_users_path

      last_response.status.should eq(200)
      JSON.parse(last_response.body)['user'].should include({
        'avatar_url' => @user.avatar_url,
        'nickname' => @user.nickname
      })
    end
  end
end