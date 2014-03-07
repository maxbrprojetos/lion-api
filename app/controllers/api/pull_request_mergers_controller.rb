class Api::PullRequestMergersController < ApplicationController
  def create
    if action == 'closed' && params[:pull_request][:merged] == true
      if user
        PullRequestMerger.create!(user_id: user.id, pull_request: params[:pull_request])
      end
    end

    head :ok
  end

  private

  def user
    @user ||= User.where(nickname: params[:pull_request][:user][:login]).first
  end

  def action
    # the magic params[:action] masks the github param
    JSON.parse(request.body.read)['action']
  end
end
