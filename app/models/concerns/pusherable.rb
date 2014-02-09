module Pusherable
  extend ActiveSupport::Concern

  included do
    fail 'Please `gem install pusher` and configure it to run in your app!' if Pusher.app_id.blank? || Pusher.key.blank? || Pusher.secret.blank?

    attr_accessor :client_id

    after_commit :pusherable_trigger_create, on: :create
    after_commit :pusherable_trigger_update, on: :update
    after_commit :pusherable_trigger_destroy, on: :destroy

    private

    def pusherable_class_name
      self.class.name.underscore
    end

    def serialized_model
      if self.class.serializer
        self.class.serializer.new(self).to_json
      else
        to_json
      end
    end

    %w(create update destroy).each do |action_name|
      define_method("pusherable_trigger_#{action_name}") do
        Pusher.trigger('notdvs', "#{pusherable_class_name}.#{action_name}", serialized_model)
      end
    end
  end
end
