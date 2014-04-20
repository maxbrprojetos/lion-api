require 'spec_helper'

describe 'Tasks Requests' do
  describe 'GET /tasks' do
    it 'responds with a json containing the current list of tasks' do
      tasks = []
      2.times { tasks << current_user.tasks.create(title: 'lol') }

      tasks.each do |task|
        2.times { create(:comment, task: task) }
      end

      get api_tasks_path

      expect(last_response.status).to eq(200)
      parsed_response = JSON.parse(last_response.body)

      expect(parsed_response['tasks']).to eq(
        tasks.map do |task|
          {
            'id' => task.id,
            'title' => task.title,
            'created_at' => task.created_at.iso8601(3),
            'client_id' => task.client_id,
            'completed' => false,
            'user_id' => task.user.id,
            'assignee_id' => task.assignee.try(:id),
            'comment_ids' => task.comment_ids
          }
        end
      )

      expect(parsed_response['users']).to eq(
        tasks.map do |task|
          {
            'id' => task.user.id,
            'avatar_url' => task.user.avatar_url,
            'nickname' => task.user.nickname
          }
        end.uniq
      )

      expect(parsed_response['comments']).to eq(
        tasks.map(&:comments).flatten.map do |comment|
          {
            'id' => comment.id,
            'body' => comment.body,
            'created_at' => comment.created_at.iso8601(3),
            'client_id' => comment.client_id,
            'user_id' => comment.user_id,
            'task_id' => comment.task_id
          }
        end.uniq
      )
    end
  end

  describe 'POST /tasks' do
    it 'creates a task and responds with the corresponding json' do
      task_params = { title: 'test', client_id: '1234' }
      post api_tasks_path, { task: task_params }.to_json

      expect(last_response.status).to eq(201)

      expect(JSON.parse(last_response.body)['task']).to include(
        'title' => task_params[:title],
        'client_id' => task_params[:client_id]
      )
    end

    it 'sends a notification to flowdock' do
      flow = double(:flow)
      ApplicationController.any_instance.stub(flow: flow)
      task_params = { title: 'test', client_id: '1234' }

      flow.should_receive(:push_to_team_inbox).with(
        subject: 'Added Task',
        content: task_params[:title],
        tags: %w(task),
        link: 'https://as-lion.herokuapp.com/#/tasks'
      )

      post api_tasks_path, { task: task_params }.to_json
    end
  end

  describe 'PATCH /tasks/{id}' do
    it 'updates a task and responds with the corresponding json' do
      task = create(:task)
      assignee = create(:user)
      task_params = { title: 'omg', assignee_id: assignee.id }

      patch api_task_path(task), { task: task_params }.to_json

      expect(last_response.status).to eq(200)

      expect(JSON.parse(last_response.body)['task']).to include(
        'title' => task_params[:title],
        'assignee_id' => task_params[:assignee_id]
      )
    end
  end

  describe 'DESTROY /tasks/{id}' do
    it 'destroys a task and responds with no content' do
      task = create(:task)

      delete api_task_path(task)

      expect(last_response.status).to eq(204)
      expect(last_response.body).to eq('')
    end

    it 'notifies flowdock' do
      flow = double(:flow)
      ApplicationController.any_instance.stub(flow: flow)
      task = create(:task)

      flow.should_receive(:push_to_team_inbox).with(
        subject: 'Deleted Task',
        content: task.title,
        tags: %w(task),
        link: 'https://as-lion.herokuapp.com/#/tasks'
      )

      delete api_task_path(task)
    end
  end
end
