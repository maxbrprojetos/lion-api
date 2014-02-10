Konacha.configure do |config|
  require 'capybara/poltergeist'
  config.spec_dir = 'spec/javascripts'
  config.spec_matcher = /_spec\./
  config.stylesheets  = %w(application)
  config.driver = :poltergeist
end if defined?(Konacha)
