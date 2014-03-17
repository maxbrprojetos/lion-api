class Api::PullRequestsController < ApplicationController
  def create
    PullRequest.create(data: params['payload']['pull_request']) if params['payload']['action'] == 'closed'

    head :ok
  end
end
