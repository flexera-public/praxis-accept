# Praxis::Accept [![TravisCI][travis-img-url]][travis-ci-url]

[travis-img-url]:https://travis-ci.org/rightscale/praxis-accept.svg?branch=master
[travis-ci-url]:https://travis-ci.org/rightscale/praxis-accept

Praxis::Accept is a plugin that uses HTTP content negotiation to deliver API
responses in various data formats, without requiring your application to be
specifically aware of each format.

## How It Works

Your application defines its media types in terms of the structured data that they
contain; for instance, I could say that a "vnd.acme.widget" consists of mass,
density, color and flavor, and my widgets controller responds with Ruby data structures
(hashes and arrays) that represent individual widgets or collections of widgets.

When a client requests a resource, it may include an HTTP Accept header that specifies

## Testing

To run unit tests:

    bundle exec rake spec

## License

This software is released under the [MIT License](http://www.opensource.org/licenses/MIT). Please see  [LICENSE](LICENSE) for further details.

Copyright (c) 2015- RightScale
