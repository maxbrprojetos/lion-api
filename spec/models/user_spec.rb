require 'spec_helper'

describe User do
  describe "#access_token" do
    it "returns the first active access token" do
      user = build(:user)
      active_access_token = create(:access_token, :active, user: user)

      expect(user.access_token).to eq active_access_token
    end

    it "does not return inactive access tokens" do
      user = build(:user)
      create(:access_token, :inactive, user: user)

      expect(user.access_token).to eq nil
    end
  end

  describe ".clients" do
    # used real entries in db to check the sql query is ok
    let!(:user1)           { create(:user) }
    let!(:user2)           { create(:user) }
    let!(:user3)           { create(:user) }
    let!(:active_token1)   { create(:access_token, :active, user: user1) }
    let!(:active_token2)   { create(:access_token, :active, user: user2) }
    let!(:inactive_token1) { create(:access_token, :inactive, user: user1) }
    let!(:inactive_token2) { create(:access_token, :inactive, user: user3) }

    it 'returns only clients from active users' do
      expect(described_class).to receive(:github_client).with(user1.api_token).and_return('client1')
      expect(described_class).to receive(:github_client).with(user2.api_token).and_return('client2')

      expect(described_class.clients).to eq ['client1', 'client2']
    end
  end
end
