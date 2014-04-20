require 'spec_helper'

describe 'Comments Requests' do
  describe 'POST /comments' do
    let(:task) { create(:task) }
    let(:comment_params) do
      { body: 'test', client_id: '1234', task_id: task.id }
    end

    it 'creates a comment and responds with the corresponding json' do
      post api_comments_path, { comment: comment_params }.to_json

      expect(last_response.status).to eq(201)

      expect(JSON.parse(last_response.body)['comment']).to include(
        'body' => comment_params[:body],
        'task_id' => comment_params[:task_id],
        'client_id' => comment_params[:client_id]
      )
    end

    it 'sends a notification to flowdock' do
      flow = double(:flow)
      ApplicationController.any_instance.stub(flow: flow)

      flow.should_receive(:push_to_team_inbox).with(
        subject: 'Added Comment',
        content: comment_params[:body],
        tags: %w(comment),
        link: 'https://as-lion.herokuapp.com/#/tasks'
      )

      post api_comments_path, { comment: comment_params }.to_json
    end
  end

  describe 'PATCH /comments/{id}' do
    it 'updates a comment and responds with the corresponding json' do
      comment = create(:comment)
      comment_params = { body: 'omg' }

      patch api_comment_path(comment), { comment: comment_params }.to_json

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['comment']).to include(
        'body' => comment_params[:body]
      )
    end
  end

  describe 'DESTROY /comments/{id}' do
    it 'destroys a comment and responds with no content' do
      comment = create(:comment)
      delete api_comment_path(comment)

      expect(last_response.status).to eq(204)
      expect(last_response.body).to eq('')
    end
  end
end
