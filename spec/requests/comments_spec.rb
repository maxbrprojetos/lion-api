require 'spec_helper'

describe 'Comments Requests' do
  describe 'GET /comments?task_id=#' do
    it 'responds with a json containing all the comments for a task' do
      task = create(:task)
      comments = create_list(:comment, 2, task: task)

      get api_comments_path(task_id: task.id)

      expect(last_response.status).to eq(200)
      parsed_response = JSON.parse(last_response.body)

      expect(parsed_response['comments']).to eq(
        comments.map do |comment|
          {
            'id' => comment.id,
            'body' => comment.body,
            'created_at' => comment.created_at.iso8601(3),
            'client_id' => comment.client_id,
            'user_id' => comment.user_id,
            'task_id' => comment.task_id
          }
        end
      )
    end
  end

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
