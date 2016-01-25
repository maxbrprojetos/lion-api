module Api
  class StatsController < ApplicationController
    before_action :authenticate!

    def index
      case params[:category]
      when "pull_requests"
        @stats = PullRequest.all.group("user_id").count
      when "reviews"
        @stats = PullRequestReview.all.group("user_id").count
      when "additions"
        @stats = PullRequest.all.group("user_id").sum(:number_of_additions)
      when "deletions"
        @stats = PullRequest.all.group("user_id").sum(:number_of_deletions)
      when "badges"
        @stats = Badge.all.group("user_id").count
      else
        @stats = []
      end

      @stats = @stats.map do |key, value|
        {
          "id" => key,
          "avatar_url" => User.find(key).avatar_url,
          "nickname" => User.find(key).nickname,
          "count" => value
        }
      end

      render json: @stats, each_serializer: StatsSerializer, root: 'stats'
    end
  end
end
