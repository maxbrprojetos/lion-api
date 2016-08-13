require 'spec_helper'

describe 'Tokens graph', type: :request do
  describe 'mutation token_create' do
    it 'responds with a json representing the created token' do
      stub_const('ENV', 'GITHUB_APP_ID' => 'client_id')
      stub_const('ENV', 'GITHUB_APP_SECRET' => 'client_secret')
      stub_const('ENV', 'ORGANIZATION_NAME' => 'group_name')
      user_double = double(:user,
        name: 'name',
        login: 'nickname',
        email: 'email',
        avatar_url: 'avatar_url',
        id: 'github_id'
      )
      token_double = double(:token, access_token: 'token')
      user_client_double = double(:user_client,
        user: user_double,
        organizations: [double(:organization, login: 'group_name')]
      )
      app_client_double = double(:app_client)
      expect(Octokit::Client).to receive(:new)
        .with({
          client_id: ENV['GITHUB_APP_ID'],
          client_secret: ENV['GITHUB_APP_SECRET']
        }).and_return(app_client_double)
      expect(app_client_double).to receive(:exchange_code_for_token)
        .and_return(token_double)
      expect(Octokit::Client).to receive(:new)
        .with({ access_token: 'token' }).and_return(user_client_double)
        .at_most(:twice)

      post api_auth_path(query: <<~QUERY)
        mutation token_create {
          token: token_create(code: "blah") {
            id
            access_token
            expires_in
            user_id
          }
        }
      QUERY

      user = User.find_by(nickname: 'nickname')

      expect(JSON.parse(last_response.body)['data']['token']).to eq(
        'id' => user.access_token.id.to_s,
        'access_token' => user.access_token.access_token,
        'expires_in' => user.access_token.expires_in,
        'user_id' => user.id.to_s
      )
    end
  end
end
