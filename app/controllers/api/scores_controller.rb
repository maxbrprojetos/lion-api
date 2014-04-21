module Api
  class ScoresController < ApplicationController
    before_action :authenticate!

    def index
      @scores = Score.where(time_span: params[:time_span]).includes(:user)

      render json: @scores
    end
  end
end
