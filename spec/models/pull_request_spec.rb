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
    it 'sets fields from data' do
      current_user
      pull_request = PullRequest.new

      data = pull_request_notification['pull_request']
      pull_request.data = data
      pull_request.user.nickname.should eq(data['user']['login'])
      pull_request.base_repo_full_name.should eq(data['base']['repo']['full_name'])
      pull_request.number.should eq(data['number'])
      pull_request.number_of_comments.should eq(data['comments'])
      pull_request.number_of_commits.should eq(data['commits'])
      pull_request.number_of_additions.should eq(data['additions'])
      pull_request.number_of_deletions.should eq(data['deletions'])
      pull_request.number_of_changed_files.should eq(data['changed_filles'])
    end
  end

  it 'adds points to the user' do
    user = create(:user)
    pull_request = create(:pull_request, user: user)

    user.points.should eq(pull_request.send(:points))
  end
end
