Konacha.configure do |config|
  config.spec_dir = 'spec/javascripts'
  config.spec_matcher = /_spec\./
  config.stylesheets  = %w(application)
  config.driver = :selenium
end if defined?(Konacha)
