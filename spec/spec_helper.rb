Encoding.default_external = Encoding::UTF_8

require 'pry'
require 'coveralls'
require 'praxis'

Coveralls.wear! do
  add_filter "/spec/"
end

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

class StubRequest
  attr_accessor :env

  def initialize(env={})
    self.env = env
  end

  include Praxis::Accept::Request
end

class StubResponse
  attr_accessor :request
  attr_accessor :body, :content_type

  def initialize(body=nil, ct=nil)
    @request = StubRequest.new
    self.body = body if body
    self.content_type = ct if ct
  end

  def encode!
    true
  end

  include Praxis::Accept::Response
end

Praxis::Application.instance.handlers['json'] = Praxis::Handlers::JSON
