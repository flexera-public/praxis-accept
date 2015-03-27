lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'praxis-accept/version'

Gem::Specification.new do |spec|
  spec.name          = "praxis-accept"
  spec.version       = Praxis::Accept::VERSION
  spec.authors = ["Tony Spataro"]
  spec.summary = %q{Content negotiation for Praxis.}
  spec.email = ["rubygems@rightscale.com"]
  
  spec.homepage = "https://github.com/rightscale/praxis-accept"
  spec.license = "MIT"
  spec.required_ruby_version = ">=2.1"

  spec.require_paths = ["lib"]
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  
  spec.add_runtime_dependency("praxis", ["~> 0"])

  spec.add_development_dependency("bundler", ["~> 1.6"])
  spec.add_development_dependency("guard", ["~> 2"])
  spec.add_development_dependency("guard-rspec", [">= 0"])
  spec.add_development_dependency("pry", ["~> 0.10"])
  spec.add_development_dependency("pry-byebug", ["~> 2.0"])
  spec.add_development_dependency("rake", ["~> 0"])
  spec.add_development_dependency("rspec", ["~> 3.0"])
  spec.add_development_dependency("yard", ["~> 0.8.7"])
end
