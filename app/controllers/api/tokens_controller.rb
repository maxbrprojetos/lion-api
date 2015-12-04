module Api
  class TokensController < ApplicationController
    def create
      token = app_client.exchange_code_for_token(params[:code])
      user_data = user_client(token).user

      if user_data.email.blank?
        user_data.email = @user_client.emails.find { |e| e.primary }.email
      end

      user = User.find_or_create_from_oauth(user_data, token.access_token)

      if user.present? && user.persisted?
        render json: user.access_tokens.first_or_create
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end

    private

    def app_client
      @app_client ||= Octokit::Client.new(
        client_id: ENV['GITHUB_APP_ID'],
        client_secret: ENV['GITHUB_APP_SECRET']
      )
    end

    def user_client(token)
      @user_client ||= Octokit::Client.new(access_token: token.access_token)
    end
  end
end
