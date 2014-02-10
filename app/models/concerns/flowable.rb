module Flowable
  protected

  def flow
    @flow ||= flow_or_null
  end

  def flow_or_null
    if ENV['FLOWDOCK_API_TOKEN']
      Flowdock::Flow.new(
        api_token: ENV['FLOWDOCK_API_TOKEN'],
        source: 'NOTDVS',
        from: { name: current_user.nickname, address: current_user.email }
      )
    else
      null_flow.new
    end
  end

  def null_flow
    Class.new do
      def method_missing(*args, &block)
        nil
      end
    end
  end
end
