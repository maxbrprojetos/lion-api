require 'spec_helper'

describe ApplicationController do
  it 'should build the flow object with the correct paramters' do
    ENV.stub(:[]).with('FLOWDOCK_API_TOKEN').and_return('test')

    Flowdock::Flow.should_receive(:new).with(
      api_token: 'test',
      source: 'Lion',
      from: { name: current_user.nickname, address: current_user.email }
    )

    ApplicationController.new.send(:flow)
  end
end
