require 'spec_helper'

describe ApplicationController do
  it 'should build the flow object with the correct paramters' do
    Flowdock::Flow.should_receive(:new).with(
      api_token: ENV['FLOWDOCK_API_TOKEN'],
      source: 'NOTDVS',
      from: { name: current_user.nickname, address: current_user.email }
    )

    ApplicationController.new.send(:flow)
  end
end
