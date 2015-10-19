# Praxis::Accept [![TravisCI][travis-img-url]][travis-ci-url] [![Coverage Status][coveralls-img-url]][coveralls-url] [![Dependency Status][gemnasium-img-url]][gemnasium-url]

[travis-img-url]:https://travis-ci.org/rightscale/praxis-accept.svg?branch=master
[travis-ci-url]:https://travis-ci.org/rightscale/praxis-accept
[coveralls-img-url]:https://coveralls.io/repos/rightscale/praxis-accept/badge.svg?branch=master&service=github
[coveralls-url]:https://coveralls.io/github/rightscale/praxis-accept?branch=master
[gemnasium-img-url]:https://gemnasium.com/rightscale/praxis-accept.svg
[gemnasium-url]:https://gemnasium.com/rightscale/praxis-accept

Praxis::Accept is a plugin that uses HTTP content negotiation to deliver API
responses in various data formats without requiring your application to be
specifically aware of each format.

# Installation

Add praxis-accept to your `Gemfile`:

    gem 'praxis-accept', '~> 0'

Add the plugin to your application's `config/environment.rb` and ensure that all of the
handlers that your application will use are registered with the Praxis core:

    Praxis::Application.configure do |application|
      # JSON and XML are built in, but XML needs to be explicitly enabled
      application.handler 'xml', Praxis::Handlers::XML
      # You can write custom handlers; consult documentation of Praxis::Handlers
      # for more detail
      application.handler 'bson', MyApp::Handlers::BSON

      # ... other config stuff goes here here ...

      application.bootloader.use Praxis::Accept
    end

# Usage

Simply pass an `Accept` request header that lists the content types your user agent
is willing to accept. The plugin chooses an appropriate handler and performs the
encoding for you.

    curl -H "Accept:application/xml" https://acme.com/api/widgets/1

    <widget>
        <description>My favorite widget</description>
        <color>red</color>
    </widget>

Note that praxis-accept is not strictly compliant with RFC 2616. It breaks the rules
in the following ways:
  1. If no suitable handler is found, it responds with JSON instead of `406 Not Acceptable`
  2. Content-type matching is "fuzzy"; the client can ask for `application/xml` and receive `application/vnd.acme.widget+xml`
  3. If the application responds with unstructured (string) data, content negotiation is bypassed entirely

# How It Works

Praxis applications define their media types in terms of the structured data that they
contain; for instance, I could say that a "vnd.acme.widget" consists of mass,
density, color and flavor, and my widgets controller would respond with Ruby data structures
(hashes and arrays) that represent individual widgets or collections of widgets.

Under normal operation, Praxis looks at the handler name of a response's content type
to determine how to turn these Ruby data structures into an HTTP response body. The
handler name is a Praxis concept that considers the "+suffix" of a MIME type identifier
if present, or the subype otherwise, in order to identify structured-syntax encoding that
is appropriate for that media type. For instance, all of the following types have a handler
name of "json":
  - application/json
  - text/json
  - application/vnd.acme.widget+json

The praxis-accept plugin inserts itself into the response path and manipulates the response's
Content-Type header so its suffix matches a handler that the client is willing to accept.

# Contributing

 1. Fork this repository on GitHub
 2. Create your feature branch: `git checkout -b my-new-feature`
 3. Commit your changes: `git commit -am 'Add some feature'`
 4. Push the branch to your fork: `git push origin my-new-feature`
 5. Submit a pull request
 6. Profit!

## Running the Tests

To run unit tests:

    bundle exec rake spec

## License

This software is released under the [MIT License](http://www.opensource.org/licenses/MIT). Please see  [LICENSE](LICENSE) for further details.

Copyright (c) 2015- RightScale
