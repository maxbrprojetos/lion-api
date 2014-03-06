require 'spec_helper'

describe 'Task Completions Requests' do
  before do
    @task = Task.create(title: 'test')
  end

  describe 'POST /task_completions' do
    it 'responds with a json containing the task marked as completed' do
      post api_task_completions_path, {
        task_completion: {
          user_id: current_user.id,
          task_id: @task.id
        }
      }.to_json

      last_response.status.should eq(201)
      parsed_response = JSON.parse(last_response.body)

      parsed_response['task_completion']['task'].should include('completed' => true)
      parsed_response['task_completion']['user']['id'].should eq(current_user.id)
    end

    it 'sends a notification to flowdock' do
      flow = double(:flow)
      ApplicationController.any_instance.stub(flow: flow)

      flow.should_receive(:push_to_team_inbox).with(
        subject: 'Completed Task',
        content: @task.title,
        tags: %w(task),
        link: 'https://notdvs.herokuapp.com/#/tasks'
      )

      post api_task_completions_path, {
        task_completion: {
          user_id: current_user.id,
          task_id: @task.id
        }
      }.to_json
    end
  end

  describe 'DELETE /task_completions' do
    it 'responds with a json containing the task marked as not completed' do
      TaskCompletion.create(task: @task)

      delete api_task_completions_path, { task_id: @task.id }.to_json

      last_response.status.should eq(200)
      parsed_response = JSON.parse(last_response.body)

      parsed_response['task_completion']['task'].should include('completed' => false)
    end

    it "responds with 404 if it can't find the task completion" do
      delete api_task_completions_path, { task_id: '98beb7fd-f051-4f94-8fb2-c30255de5fab' }.to_json

      last_response.status.should eq(404)
    end
  end
end
