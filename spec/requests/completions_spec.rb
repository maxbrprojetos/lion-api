require 'spec_helper'

describe 'Completions Requests' do
  before do
    @task = Task.create(title: 'test')
  end

  describe 'POST /completions' do
    it 'responds with a json containing the completable object marked as completed' do
      $flow = double(:flow).as_null_object
      post api_completions_path, { completable: { type: 'Task', id: @task.id } }.to_json

      last_response.status.should eq(201)
      parsed_response = JSON.parse(last_response.body)

      parsed_response['task'].should include({
        'completed' => true
      })
    end

    it 'sends a notification to flowdock' do
      $flow = double(:flow)

      $flow.should_receive(:push_to_team_inbox).with(
        subject: 'Task Completed',
        content: @task.title,
        tags: ['notdvs', 'task'],
        link: 'https://notdvs.herokuapp.com/#/tasks'
      )

      post api_completions_path, { completable: { type: 'Task', id: @task.id } }.to_json
    end
  end

  describe 'DELETE /completions' do
    it 'responds with a json containing the completable object marked as not completed' do
      completion = Completion.create(completable: @task)
      delete api_completions_path, { completable: { type: 'Task', id: @task.id } }.to_json

      last_response.status.should eq(200)
      parsed_response = JSON.parse(last_response.body)

      parsed_response['task'].should include({
        'completed' => false
      })
    end

    it "responds with 404 if it can't find the completion" do
      delete api_completions_path(completable: { type: 'Task', id: '98beb7fd-f051-4f94-8fb2-c30255de5fab' })

      last_response.status.should eq(404)
    end
  end
end