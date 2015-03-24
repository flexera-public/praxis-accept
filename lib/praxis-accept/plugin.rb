module Praxis::Accept
  class Plugin < Praxis::Plugin
    include Singleton

    # Initialize a new instance of the singleton plugin; it has no state, so this is a very
    # boring method.
    def initialize
    end

    # This plugin requires no authentication, but the framework needs us to declare a config_key
    # anyway.
    def config_key
      :accept
    end
  end
end
