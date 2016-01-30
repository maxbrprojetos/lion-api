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
  describe '#data=' do
    it 'sets fields from data' do
      current_user

      pull_request = PullRequest.new
      allow(pull_request).to receive(:comments).and_return([])

      data = pull_request_notification['payload']['pull_request']
      pull_request.data = data
      expect(pull_request.user.nickname).to eq(data['user']['login'])
      expect(pull_request.base_repo_full_name).to eq(data['base']['repo']['full_name'])
      expect(pull_request.number).to eq(data['number'])
      expect(pull_request.number_of_comments).to eq(data['comments'])
      expect(pull_request.number_of_commits).to eq(data['commits'])
      expect(pull_request.number_of_additions).to eq(data['additions'])
      expect(pull_request.number_of_deletions).to eq(data['deletions'])
      expect(pull_request.number_of_changed_files).to eq(data['changed_files'])
      expect(pull_request.merged_at).to eq(Time.parse(data['merged_at']))
    end
  end

  it 'adds points to the user' do
    user = create(:user)
    pull_request = build(:pull_request, user: user)
    allow(pull_request).to receive(:comments).and_return([])
    pull_request.save!

    score = Score.first
    expect(score.user).to eq(pull_request.user)
    expect(score.points).to eq(pull_request.points)
  end

  it 'adds pull request reviews' do
    current_user

    pull_request = build(:pull_request)
    allow(pull_request).to receive(:comments).and_return([double(
      body: ':+1:', user_nickname: 'current_user', user: double(login: 'current_user')
    )])

    pull_request.save
    expect(PullRequestReview.count).to eq(1)
  end
end
