require 'spec_helper'

describe 'PullRequest Mergers Requests' do
  let(:params) do
    pull_request_notification
  end

  describe 'POST /pull_request_mergers' do
    it 'creates a PullRequestMerger' do
      post api_pull_request_mergers_path, params.to_json

      pull_request_merger = PullRequestMerger.first
      pull_request_merger.should be_present
      pull_request_merger.pull_request['merged'].should eq('true')
      pull_request_merger.user.should eq(current_user)
    end
  end
end
