ruby '2.1.1'
source 'https://rubygems.org'

gem 'rails', '4.1.0.rc1'

gem 'active_model_serializers'
gem 'pusher'
gem 'dotenv'
gem 'thin'
gem 'pg'
gem 'omniauth'
gem 'omniauth-github'
gem 'octokit', github: 'octokit/octokit.rb'
gem 'flowdock'
gem 'newrelic_rpm'
gem 'honeybadger'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'ember-rails'
gem 'emblem-rails'
gem 'foundation-rails'
gem 'bourbon'
gem 'zocial-rails'

gem 'rails_12factor', group: :production

group :development do
  gem 'annotate', github: 'ctran/annotate_models'
  gem 'spring'
  gem 'quiet_assets'
end

group :test, :development do
  gem 'jazz_hands'
  gem 'konacha'
  gem 'sinon-rails'
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-konacha'
  gem 'rubocop'
  gem 'rspec_api_blueprint', github: 'playround/rspec_api_blueprint', require: false
  gem 'factory_girl_rails', github: 'thoughtbot/factory_girl_rails'
end

group :test do
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
  gem 'cucumber-rails', require: false
end
