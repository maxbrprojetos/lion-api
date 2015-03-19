ruby '2.1.4'
source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.1.1'
gem 'rails-api'

# Needs to load first, so that gems that configure themself by enviroment
# variables will see the variables when they load
gem 'dotenv'

gem 'active_model_serializers'
gem 'pusher'
gem 'thin'
gem 'pg'
gem 'omniauth'
gem 'omniauth-github'
gem 'octokit', git: 'https://github.com/octokit/octokit.rb.git'
gem 'flowdock'
gem 'newrelic_rpm'
gem 'honeybadger'
gem 'skylight'
gem 'pushable-rails', require: 'pushable'
gem 'rack-cors'
gem 'sidekiq'
gem 'sinatra', require: nil

gem 'rails_12factor', group: :production

group :development do
  gem 'annotate', github: 'ctran/annotate_models'
  gem 'spring'
  gem 'bullet'
end

group :test, :development do
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'guard-rspec', require: false
  gem 'guard-annotate', require: false
  gem 'terminal-notifier-guard', require: false
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
