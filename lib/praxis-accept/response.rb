require 'active_support/concern'
require 'active_support/deprecation'
require 'active_support/core_ext/class'

module Praxis::Accept
  module Response
    # We need to detour an existing method when we're included in Praxis::Response
    extend ActiveSupport::Concern

    included do
      alias_method_chain :encode!, :content_negotiation
    end

    # If the response is structured data and the request included an Accept header, find the
    # first Accept-able content type that we can handle and set the suffix of our response
    # content type so the Praxis core will encode using that handler.
    def encode_with_content_negotiation!
      case @body
      when Hash, Array
        if request
          acceptable_content_type = request.acceptable_content_types.detect do |mti|
            Praxis::Application.instance.handlers.key?(mti.handler_name)
          end
        end

        content_type = self.content_type

        if acceptable_content_type
          # Set handler-specific suffix so Praxis core will use the handler we found
          self.content_type = content_type + acceptable_content_type.handler_name
        elsif content_type.suffix.empty?
          # Set JSON suffix to guarantee core JSON encoding and provide predictable
          # behavior for client
          self.content_type = content_type + 'json'
        end
      end

      encode_without_content_negotiation!
    end
  end
end
