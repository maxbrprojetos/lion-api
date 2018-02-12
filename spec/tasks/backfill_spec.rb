require 'spec_helper'
require 'rake'

describe 'Backfill Tasks', type: :task do
  before :all do
    Rake.application.rake_require 'tasks/backfill'
    Rake::Task.define_task(:environment)
  end

  describe 'Update a Pull Request Attribute' do
    let(:response) { get_pull_request }
    let(:pull_request) { create(:pull_request, { base_repo_full_name: 'octocat/Hello-World', number: 1347 }) }

    let(:run_rake_task) do
      Rake::Task["backfill:update_pull_request_attribute"].reenable
      Rake.application.invoke_task "backfill:update_pull_request_attribute[#{pull_request.id},title]"
    end

    it 'updates the pull request with a title from the Github client response' do
      allow(User).to receive(:global_client) { Octokit::Client.new }
      allow_any_instance_of(Octokit::Client).to receive(:pull_request) { response }
      expect(STDOUT).to receive(:puts).with("Updated #{pull_request.base_repo_full_name}##{pull_request.number} title from #{pull_request.title.nil? ? 'nil': pull_request.title} to #{response['title']}.")
      run_rake_task
    end
  end
end
