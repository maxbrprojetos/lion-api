require 'spec_helper'

describe Api::UsersController, type: :controller do
  describe "GET #me" do
    it "requires an access token" do
      get :me
      expect(response.status).to eq(401)
      expect(response.headers['WWW-Authenticate']).to match(/^Bearer/)
    end

    it "returns the current user" do
      access_token = create(:access_token, user: current_user)
      mock_access_token_for(access_token.user)

      get :me

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)
      expect(response.body).to eq UserSerializer.new(current_user).to_json
    end
  end

  describe "GET #index" do
    it "requires an access token" do
      get :index
      expect(response.status).to eq(401)
      expect(response.headers['WWW-Authenticate']).to match(/^Bearer/)
    end

    it "returns all users" do
      users = create_list(:user, 5)
      users = users << current_user
      access_token = create(:access_token, user: current_user)
      mock_access_token_for(access_token.user)

      get :index

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response["users"].length).to eq(6)
    end
  end

  describe "GET #show" do
    it "requires an access token" do
      get :show, id: 1
      expect(response.status).to eq(401)
      expect(response.headers['WWW-Authenticate']).to match(/^Bearer/)
    end

    it "returns a user" do
      users = create_list(:user, 5)
      users = users << current_user
      sought_user = User.first
      access_token = create(:access_token, user: current_user)
      mock_access_token_for(access_token.user)

      get :show, id: sought_user.id

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)
      expect(response.body).to eq UserSerializer.new(sought_user).to_json
    end
  end
end
