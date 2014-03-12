class Api::PullRequestsController < ApplicationController
  def create
    PullRequest.create(data: params['pull_request']) if action == 'closed'

    head :ok
  end

  private

  def action
    # the magic params[:action] masks the github param
    JSON.parse(request.body.read)['action']
  end
end
