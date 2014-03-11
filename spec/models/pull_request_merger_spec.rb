# == Schema Information
#
# Table name: pull_request_mergers
#
#  id         :uuid             not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe PullRequestMerger do
  describe 'create' do
    it 'gives points to the user' do
      user = create(:user)

      PullRequestMerger.create(pull_request: { merged: true, user: { login: user.nickname } })

      user.reload.points.should eq(PullRequestMerger.points)
    end
  end
end
