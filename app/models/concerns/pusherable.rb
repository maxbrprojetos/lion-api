module Pusherable
  extend ActiveSupport::Concern

  included do
    attr_accessor :client_id

    def self.pusherable(serializer: nil)
      raise 'Please `gem install pusher` and configure it to run in your app!' if Pusher.app_id.blank? || Pusher.key.blank? || Pusher.secret.blank?

      class_eval do
        after_commit :pusherable_trigger_create, on: :create
        after_commit :pusherable_trigger_update, on: :update
        after_commit :pusherable_trigger_destroy, on: :destroy

        private

        def pusherable_class_name
          self.class.name.underscore
        end

        %w(create update destroy).each do |action_name|
          define_method("pusherable_trigger_#{action_name}") do
            serialized_model = if serializer
              serializer.new(self).to_json
            else
              self.to_json
            end

            Pusher.trigger('notdvs', "#{pusherable_class_name}.#{action_name}", serialized_model)
          end
        end
      end
    end
  end
end