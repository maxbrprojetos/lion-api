class Api::UsersController < ApplicationController
  def me
    @user = User.where(api_token: request.authorization.gsub(/^Bearer /, '')).first

    render json: @user
  end
end