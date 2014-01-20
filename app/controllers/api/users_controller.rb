class Api::UsersController < ApplicationController
  before_action :authenticate!

  def me
    render json: current_user
  end

  def index
    @users = User.all

    render json: @users
  end
end