module PusherableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :client_id
  end
end
