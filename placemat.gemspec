# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'placemat/version'

Gem::Specification.new do |spec|
  spec.name          = "placemat"
  spec.version       = Placemat::VERSION
  spec.authors       = ["William Anderson"]
  spec.email         = ["thewilliamanderson@gmail.com"]

  spec.summary       = %q{Converts placemat markdown files into html tables.}
  spec.homepage      = "https://github.com/william-index/placemat"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["placemat"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end
