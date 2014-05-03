module Pushable
  extend ActiveSupport::Concern

  included do
    attr_accessor :client_id

    after_commit :pusherable_trigger_create, on: :create
    after_commit :pusherable_trigger_update, on: :update
    after_commit :pusherable_trigger_destroy, on: :destroy

    private

    def pusherable_class_name
      self.class.name.underscore
    end

    def serialized_model
      "#{self.class.name}Serializer".constantize.new(self).to_json
    rescue NameError
      to_json
    end

    %w(create update destroy).each do |action_name|
      define_method("pusherable_trigger_#{action_name}") do
        Pusher.trigger('lion', "#{pusherable_class_name}.#{action_name}", serialized_model)
      end
    end
  end
end
