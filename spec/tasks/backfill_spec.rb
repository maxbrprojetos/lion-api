require 'rake'
require 'spec_helper'

describe 'Backfill Tasks', type: :task do
  before :all do
    Rake.application.rake_require 'tasks/backfill'
    Rake::Task.define_task(:environment)
  end

  describe 'Update Pull Requests Title Attribute' do
    let(:response) { get_pull_request }
    let(:pull_request_with_title) { create(:pull_request, { base_repo_full_name: 'octocat/Hello-World', number: 1347, title: 'Replaced semicolons with commas' }) }
    let(:pull_request_without_title_one) { create(:pull_request, { base_repo_full_name: 'octocat/Hello-World', number: 1348 }) }
    let(:pull_request_without_title_two) { create(:pull_request, { base_repo_full_name: 'octocat/Hello-World', number: 1349 }) }
    let(:pull_request_response) { OpenStruct.new(:title => 'Replaced all the commas with periods') }

    let(:run_rake_task) do
      Rake::Task["backfill:update_pull_request_titles"].reenable
      Rake.application.invoke_task "backfill:update_pull_request_titles"
    end

    it 'updates the pull request with a title from the Github client response' do
      create(:pull_request, { base_repo_full_name: 'octocat/Hello-World', number: 1347, title: 'Replaced semicolons with commas' })
      pull_request_without_title_one = create(:pull_request, { base_repo_full_name: 'octocat/Hello-World', number: 1348 })
      pull_request_without_title_two = create(:pull_request, { base_repo_full_name: 'octocat/Hello-World', number: 1349 })

      allow(User).to receive(:global_client) { Octokit::Client.new }
      allow_any_instance_of(Octokit::Client).to receive(:pull_request) { pull_request_response }

      expect(STDOUT).to receive(:puts).with("Successfully updated 2 Pull Requests.")
      run_rake_task
      expect(pull_request_without_title_one.reload.title).to eq 'Replaced all the commas with periods'
    end
  end
end
