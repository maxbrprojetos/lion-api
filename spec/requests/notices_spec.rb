require 'spec_helper'

describe 'Notices Requests' do
  describe 'GET /notices' do
    it 'responds with a json containing the current list of notices' do
      notices = []
      2.times { notices << Notice.create(title: 'lol') }
      get api_notices_path

      last_response.status.should eq(200)

      JSON.parse(last_response.body)['notices'].should eq(
        notices.map do |notice|
          {
            'id' => notice.id,
            'title' => notice.title,
            'created_at' => notice.created_at.iso8601(3),
            'client_id' => notice.client_id,
            'type' => notice.type,
            'app' => notice.app
          }
        end
      )
    end
  end

  describe 'POST /notices' do
    it 'creates a notice and responds with the corresponding json' do
      Notdvs.stub(flow: double(:flow).as_null_object)
      notice_params = { title: 'test', client_id: '1234', app: 'testapp', type: 'error' }
      post api_notices_path, { notice: notice_params }.to_json

      last_response.status.should eq(201)

      JSON.parse(last_response.body)['notice'].should include(
        'title' => notice_params[:title],
        'client_id' => notice_params[:client_id],
        'app' => notice_params[:app],
        'type' => notice_params[:type]
      )
    end

    it 'sends a notification to flowdock' do
      Notdvs.stub(flow: double(:flow))
      notice_params = { title: 'test', client_id: '1234', app: 'testapp', type: 'error' }

      Notdvs.flow.should_receive(:push_to_team_inbox).with(
        subject: "Added Notice for #{notice_params[:app].capitalize}",
        content: notice_params[:title],
        tags: %w(notice new),
        link: 'https://notdvs.herokuapp.com'
      )

      post api_notices_path, { notice: notice_params }.to_json
    end
  end

  describe 'DESTROY /notices/{id}' do
    it 'destroys a notice and responds with no content' do
      Notdvs.stub(flow: double(:flow).as_null_object)
      notice = Notice.create(title: 'test', app: 'testapp')

      delete api_notice_path(notice)

      last_response.status.should eq(204)
      last_response.body.should eq('')
    end

    it 'notifies flowdock' do
      Notdvs.stub(flow: double(:flow))
      notice = Notice.create(title: 'test', app: 'testapp')

      Notdvs.flow.should_receive(:push_to_team_inbox).with(
        subject: "Deleted Notice for #{notice.app.capitalize}",
        content: notice.title,
        tags: %w(notice deleted),
        link: 'https://notdvs.herokuapp.com'
      )

      delete api_notice_path(notice)
    end
  end
end
