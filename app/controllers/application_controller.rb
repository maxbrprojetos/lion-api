class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.where(api_token: request.authorization.gsub(/^Bearer /, '')).first
  end
end
