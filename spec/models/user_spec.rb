# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  name       :string(255)
#  nickname   :string(255)
#  email      :string(255)
#  avatar_url :string(255)
#  api_token  :string(255)
#  github_id  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

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
end
