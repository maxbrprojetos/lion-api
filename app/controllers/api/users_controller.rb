module Api
  class UsersController < ApplicationController
    before_action :authenticate!

    def me
      render json: current_user
    end

    def index
      @users = User.all

      render json: @users
    end

    def show
      @user = User.find(params[:id])

      render json: @user
    end
  end
end
