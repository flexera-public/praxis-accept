module Praxis::Accept
  module Request
    ACCEPT_NAME = 'HTTP_ACCEPT'.freeze

    # Parse the HTTP Accept header (if present) and return all of the media type identifiers
    # that the user-agent will accept in the order that the user-agent prefers them.
    #
    # @return [Array] collection of MediaTypeIdentifier objects
    #
    # @todo order acceptable content types by 'q' parameters, not by lexical order
    def acceptable_content_types
      accept_header = @env[ACCEPT_NAME] || ''
      acceptable = accept_header.split(/\s*,\s*/)

      acceptable = acceptable.map do |media_range|
        begin
          Praxis::MediaTypeIdentifier.new(media_range)
        end
      end
    end
  end
end
