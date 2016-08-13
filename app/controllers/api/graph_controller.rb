module Api
  class GraphController < ApplicationController
    before_action :authenticate!

    def execute
      result = Graph::Schema.execute(
        params[:query],
        context: { current_user: current_user }
      )

      render json: result
    end
  end
end
