module Api
  class GraphController < ApplicationController
    before_action :authenticate!

    def execute
      result = Graph::Schema.execute(
<<<<<<< HEAD
        graphql_params[:query],
=======
        params[:query],
>>>>>>> origin/master
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
