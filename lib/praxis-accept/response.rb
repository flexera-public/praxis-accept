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
        acceptable_content_type = request.acceptable_content_types.detect do |mti|
          Praxis::Application.instance.handlers[mti.handler_name] && mti.handler_name
        end

        if acceptable_content_type
          # Set suffix of response content_type so Praxis core will use the handler we found
          self.content_type = self.content_type + acceptable_content_type.handler_name
        end
      end

      encode_without_content_negotiation!
    end
  end
end
