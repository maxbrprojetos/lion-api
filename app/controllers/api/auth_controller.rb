module Api
  class AuthController < ApplicationController
    def execute
      result = Graph::AuthSchema.execute(
        params[:query],
        context: { current_user: current_user }
      )

      render json: result
    end
  end
end
