class Api::PullRequestMergersController < ApplicationController
  def create
    if action == 'closed'
      PullRequestMerger.create(pull_request: params[:pull_request])
    end

    head :ok
  end

  private

  def action
    # the magic params[:action] masks the github param
    JSON.parse(request.body.read)['action']
  end
end
