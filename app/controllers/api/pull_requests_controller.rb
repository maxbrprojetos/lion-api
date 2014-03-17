class Api::PullRequestsController < ApplicationController
  def create
    PullRequest.create(data: pull_request_params) if action == 'closed'

    head :ok
  end

  private

  def pull_request_params
    if params['payload']
      params['payload']['pull_request']
    else
      params['pull_request']
    end
  end

  def action
    # the magic params[:action] masks the github param
    if params['payload']
      params['payload']['action']
    else
      JSON.parse(request.body.read)['action']
    end
  end
end
