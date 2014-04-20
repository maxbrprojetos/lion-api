ruby '2.1.1'
source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.1'

# Needs to load first, so that gems that configure themself by enviroment
# variables will see the variables when they load
gem 'dotenv'

gem 'active_model_serializers'
gem 'pusher'
gem 'thin'
gem 'pg'
gem 'omniauth'
gem 'omniauth-github'
gem 'octokit', github: 'octokit/octokit.rb'
gem 'flowdock'
gem 'newrelic_rpm'
gem 'honeybadger'
gem 'skylight'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'emblem-rails'
gem 'foundation-rails'
gem 'bourbon'
gem 'zocial-rails'
gem 'font-awesome-rails'
gem 'rails-assets-jquery', '2.0'
gem 'rails-assets-ember', '1.5.0'
gem 'rails-assets-ember-data', '1.0.0.beta7'
gem 'rails-assets-pusher'
gem 'rails-assets-pace'
gem 'rails-assets-moment'

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
  gem 'guard-rubocop', require: false
  gem 'guard-konacha', require: false
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
