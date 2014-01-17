require 'spec_helper'

describe 'Tasks Requests' do
  describe 'GET /tasks' do
    it 'responds with a json containing the current list of tasks' do
      tasks = []
      2.times { tasks << Task.create(title: 'lol') }
      get api_tasks_path

      last_response.status.should eq(200)

      JSON.parse(last_response.body)['tasks'].should eq(
        tasks.map do |task|
          {
            'id' => task.id,
            'title' => task.title,
            'created_at' => task.created_at.iso8601(3),
            'client_id' => task.client_id,
            'completed' => false
          }
        end
      )
    end
  end

  describe 'POST /tasks' do
    it 'creates a task and responds with the corresponding json' do
      task_params = { title: 'test', client_id: '1234' }
      post api_tasks_path, { task: task_params }.to_json

      last_response.status.should eq(201)

      JSON.parse(last_response.body)['task'].should include(
        {
          'title' => task_params[:title],
          'client_id' => task_params[:client_id]
        }
      )
    end
  end

  describe 'PATCH /tasks/{id}' do
    it 'updates a task and responds with the corresponding json' do
      task = Task.create(title: 'test')
      task_params = { title: 'omg', completed: true }

      patch api_task_path(task), { task: task_params }.to_json

      last_response.status.should eq(200)

      JSON.parse(last_response.body)['task'].should include({
        'title' => task_params[:title],
        'completed' => task_params[:completed]
      })
    end
  end

  describe 'DESTROY /tasks/{id}' do
    it 'destroys a task and responds with no content' do
      task = Task.create(title: 'test')

      delete api_task_path(task)

      last_response.status.should eq(204)
      last_response.body.should eq('')
    end
  end
end