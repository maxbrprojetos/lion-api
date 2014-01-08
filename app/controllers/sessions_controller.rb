class SessionsController < ApplicationController
  def create
    render :create, layout: false
  end
end