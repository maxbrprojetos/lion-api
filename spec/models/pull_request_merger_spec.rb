# == Schema Information
#
# Table name: pull_request_mergers
#
#  id           :uuid             not null, primary key
#  pull_request :hstore
#  user_id      :uuid
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe PullRequestMerger do
  describe 'create' do
    it 'gives points to the user' do
      user = create(:user)

      PullRequestMerger.create!(user: user, pull_request: { test: 'lol' })

      user.points.should eq(PullRequestMerger.points)
    end
  end
end
