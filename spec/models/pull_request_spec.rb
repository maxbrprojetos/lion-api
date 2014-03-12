# == Schema Information
#
# Table name: pull_requests
#
#  id                  :uuid             not null, primary key
#  base_repo_full_name :string(255)
#  number              :integer
#  user_id             :uuid
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe PullRequest do
  describe '#data=' do
    it 'sets the user, base_repo_full_name and number' do
      current_user
      pull_request = PullRequest.new

      data = pull_request_notification['pull_request']
      pull_request.data = data
      pull_request.user.nickname.should eq(data['user']['login'])
      pull_request.base_repo_full_name.should eq(data['base']['repo']['full_name'])
      pull_request.number.should eq(data['number'])
    end
  end
end
