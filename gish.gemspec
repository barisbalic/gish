# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gish/version'

Gem::Specification.new do |spec|
  spec.name          = "gish"
  spec.version       = Gish::VERSION
  spec.authors       = ["Baris Balic"]
  spec.email         = ["leafybasil@gmail.com"]
  spec.description   = %q{Gish brings Github Issues to the command-line.}
  spec.summary       = %q{A fairly functional command-line interface for the most excellent Gitub Issues.}
  spec.homepage      = "http://github.com/barisbalic/gish"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'octokit'
  spec.add_dependency 'thor'
end
