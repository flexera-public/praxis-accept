Encoding.default_external = Encoding::UTF_8

require 'pry'

require 'praxis-accept'

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    /gems/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/,
    /org\/jruby\/.*.java/
  ]
end
