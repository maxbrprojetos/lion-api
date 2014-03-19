# == Schema Information
#
# Table name: pull_requests
#
#  id                      :uuid             not null, primary key
#  base_repo_full_name     :string(255)
#  number                  :integer
#  user_id                 :uuid
#  created_at              :datetime
#  updated_at              :datetime
#  number_of_comments      :integer
#  number_of_commits       :integer
#  number_of_additions     :integer
#  number_of_deletions     :integer
#  number_of_changed_files :integer
#  merged_at               :datetime
#

require 'spec_helper'

describe PullRequest do
  let(:pull_request) { PullRequest.new.tap { |pr| pr.stub(comments: []) } }

  describe '#data=' do
    it 'sets fields from data' do
      current_user

      data = pull_request_notification['payload']['pull_request']
      pull_request.data = data
      pull_request.user.nickname.should eq(data['user']['login'])
      pull_request.base_repo_full_name.should eq(data['base']['repo']['full_name'])
      pull_request.number.should eq(data['number'])
      pull_request.number_of_comments.should eq(data['comments'])
      pull_request.number_of_commits.should eq(data['commits'])
      pull_request.number_of_additions.should eq(data['additions'])
      pull_request.number_of_deletions.should eq(data['deletions'])
      pull_request.number_of_changed_files.should eq(data['changed_files'])
      pull_request.merged_at.should eq(data['merged_at'])
    end
  end

  it 'adds points to the user' do
    user = create(:user)
    pull_request = build(:pull_request, user: user).tap { |pr| pr.stub(comments: []) }
    pull_request.save!

    score = Score.first
    score.user.should eq(pull_request.user)
    score.points.should eq(pull_request.points)
  end

  it 'adds pull request reviews' do
    pull_request = build(:pull_request)
    pull_request.stub(comments: [double(
      body: ':+1:', user_nickname: 'current_user', user: double(login: 'current_user')
    )])

    pull_request.save
    PullRequestReview.count.should eq(1)
  end
end
