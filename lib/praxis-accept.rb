require 'praxis-accept/version'

module Praxis
  module Accept
    include Praxis::PluginConcern
  end
end

require 'praxis-accept/plugin'
require 'praxis-accept/request'
require 'praxis-accept/response'
