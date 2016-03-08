ruby '2.3.0'

source 'https://rubygems.org'

# Needs to load first, so that gems that configure themself by enviroment
# variables will see the variables when they load
gem 'dotenv'

gem 'rails', '~> 4.1.14.2'
gem 'rails-api'
gem 'active_model_serializers', '~> 0.8.0'
gem 'puma'
gem 'pg'
gem 'octokit'
gem 'honeybadger'
gem 'skylight'
gem 'rack-cors'
gem 'sidekiq'
gem 'sinatra', require: nil

gem 'rails_12factor', group: :production

group :development do
  gem 'spring'
  gem 'bullet'
end

group :test, :development do
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'rubocop'
  gem 'factory_girl_rails', github: 'thoughtbot/factory_girl_rails'
  gem 'faker'
end
