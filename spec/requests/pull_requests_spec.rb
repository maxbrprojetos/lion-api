require 'spec_helper'

describe 'PullRequests Requests' do
  let(:params) do
    pull_request_notification
  end

  describe 'POST /pull_requests' do
    it 'creates a PullRequest' do
      post api_pull_requests_path, params.to_json

      pull_request = PullRequest.first
      pull_request.should be_present
      pull_request.user.should eq(current_user)
    end
  end
end
