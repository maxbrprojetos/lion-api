ruby '2.3.1'

source 'https://rubygems.org'

# Needs to load first, so that gems that configure themself by enviroment
# variables will see the variables when they load
gem 'dotenv'

gem 'rails', '~> 5.1.0'
gem 'puma'
gem 'pg'
gem 'octokit'
gem 'honeybadger'
gem 'skylight'
gem 'rack-cors'
gem 'sidekiq'
gem 'sinatra'
gem 'lograge'
gem 'rails_12factor', group: :production
gem 'graphql'
gem 'graphql-batch'
gem 'tzinfo-data'

group :development do
  gem 'bullet'
  gem 'thor-rails'
end

group :test, :development do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end
