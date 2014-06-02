# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minty/version'

Gem::Specification.new do |spec|
  spec.name          = "minty"
  spec.version       = Minty::VERSION
  spec.authors       = ["Matt Bridges"]
  spec.email         = ["mbridges.91@gmail.com"]
  spec.description   = %q{Ruby Library for Mint.com}
  spec.summary       = %q{Ruby Library for Mint.com}
  spec.homepage      = "https://github.com/mattdbridges/minty"
  spec.license       = "MIT"
  spec.executables   << "minty"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "mechanize",  "~> 2.7.2"
  spec.add_runtime_dependency "text-table", "~> 1.2.3"
  spec.add_runtime_dependency "mixlib-cli", "~> 1.3.0"
end
