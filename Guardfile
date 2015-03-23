# Config file for Guard
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/praxis-accept/(.+)\.rb$}) { |m| "spec/praxis-accept/#{m[1]}_spec.rb" }
  watch('spec/*.rb')  { 'spec' }
  watch('lib/praxis-accept.rb') { 'spec' }
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
end

