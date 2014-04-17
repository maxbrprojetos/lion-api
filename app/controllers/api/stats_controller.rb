module Api
  class StatsController < ApplicationController
    before_action :authenticate!

    def index
      @users = User.all

      render json: @users, each_serializer: StatsSerializer, root: 'stats'
    end
  end
end
