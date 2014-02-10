class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.where(api_token: request.authorization.try(:gsub, /^Bearer /, '')).first
  end

  def authenticate!
    head :unauthorized unless current_user.present?
  end

  protected

  def flow
    @flow ||= Flowdock::Flow.new(
      api_token: ENV['FLOWDOCK_API_TOKEN'],
      source: 'NOTDVS',
      from: { name: current_user.nickname, address: current_user.email }
    )
  end
end
