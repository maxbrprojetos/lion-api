module Api
  class StatsController < ApplicationController
    before_action :authenticate!

    def index
      @stats = case params[:category]
        when "pull_requests"
          PullRequest.all.group("user_id").count
        when "reviews"
          PullRequestReview.all.group("user_id").count
        when "additions"
          PullRequest.all.group("user_id").sum(:number_of_additions)
        when "deletions"
          PullRequest.all.group("user_id").sum(:number_of_deletions)
        else []
      end

      @stats = @stats.map do |key, value|
        user = User.find(key)
        {
          "id" => key,
          "avatar_url" => user.avatar_url,
          "nickname" => user.nickname,
          "count" => value
        }
      end

      render json: @stats, each_serializer: StatsSerializer, root: 'stats'
    end
  end
end
