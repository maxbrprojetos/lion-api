require 'spec_helper'

describe 'PullRequests Requests', type: :request do
  let(:params) do
    pull_request_notification
  end

  describe 'POST /pull_requests' do
    it 'creates a PullRequest' do
      allow_any_instance_of(PullRequest).to receive(:comments).and_return([])
      post api_pull_requests_path, params.to_json

      pull_request = PullRequest.first
      expect(pull_request).to be_present
      expect(pull_request.user).to eq(current_user)
    end
  end
end
