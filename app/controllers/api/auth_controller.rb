module Api
  class AuthController < ApplicationController
    def execute
      result = Graph::AuthSchema.execute(
        graphql_params[:query],
        variables: graphql_params.fetch(:variables, {}),
        context: { current_user: current_user }
      )

      render json: result
    end

    private

    def graphql_params
      params.permit(:query, variables: {})
    end
  end
end
