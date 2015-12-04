require 'rubygems'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/poltergeist'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Capybara.default_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: true,
    timeout: 120,
    debug: false,
    phantomjs_options: ['--load-images=no', '--disk-cache=false'],
    inspector: true,
    stderr: nil
  }

  Capybara::Poltergeist::Driver.new(app, options)
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.mock_with :rspec

  config.include Helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    Octokit::Client.any_instance.stub(
      user: double(:user, login: nil),
      organizations: [double(:organization, login: ENV['ORGANIZATION_NAME'])]
    )

    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = Rails.root.join('spec', 'vcr', 'acceptance')
  c.hook_into :webmock
end
