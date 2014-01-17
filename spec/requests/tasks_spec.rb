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
            'client_id' => task.client_id
          }
        end
      )
    end
  end
end