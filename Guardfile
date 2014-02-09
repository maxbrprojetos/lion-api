# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'spring rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }

  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/api/(.+)_(controller)\.rb$})  { |m| ["spec/requests/#{m[1]}_spec.rb"] }
end


guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :cucumber do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

### Guard::Konacha
#  available options:
#  - :run_all_on_start, defaults to true
#  - :notification, defaults to true
#  - :rails_environment_file, location of rails environment file,
#    should be able to find it automatically
guard :konacha do
  watch(%r{^app/assets/javascripts/(.*)\.js(\.coffee)?$}) { |m| "#{m[1]}_spec.js" }
  watch(%r{^spec/javascripts/.+_spec(\.js|\.js\.coffee)$})
end
