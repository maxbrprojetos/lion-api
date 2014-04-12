module Api
  class WeeklyWinningsController < ApplicationController
    before_action :authenticate!

    def index
      @weekly_winnings = WeeklyWinning.all.order(start_date: :desc)

      render json: @weekly_winnings
    end
  end
end
