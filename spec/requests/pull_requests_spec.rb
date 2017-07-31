require 'spec_helper'

describe 'PullRequests Requests', type: :request do
  let(:params) do
    pull_request_notification
  end

  describe 'POST /pull_requests' do
    it 'creates a PullRequest' do
      allow_any_instance_of(PullRequest).to receive(:reviews).and_return([])
      post api_pull_requests_path, params.to_json

      pull_request = PullRequest.first
      expect(pull_request).to be_present
      expect(pull_request.user).to eq(current_user)
    end

    it 'does not duplicate pull requests' do
      allow_any_instance_of(PullRequest).to receive(:reviews).and_return([])

      expect{
        post api_pull_requests_path, params.to_json
      }.to change(PullRequest, :count).by 1
      expect(last_response.status).to eq 200

      expect{
        post api_pull_requests_path, params.to_json
      }.to change(PullRequest, :count).by 0
      expect(last_response.status).to eq 200
    end
  end
end
