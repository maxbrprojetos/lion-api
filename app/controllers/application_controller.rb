class ApplicationController < ActionController::API
  include Flowable

  def current_user
    @current_user ||= User.where(api_token: request.authorization.try(:gsub, /^Bearer /, '')).first
  end

  def authenticate!
    head :unauthorized unless current_user.present?
  end
end
