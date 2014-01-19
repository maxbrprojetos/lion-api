class Api::UsersController < ApplicationController
  def me
    render json: current_user
  end

  def index
    @users = User.all

    render json: @users
  end
end