# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markify/version'

Gem::Specification.new do |spec|
  spec.name          = Markify::NAME.downcase
  spec.version       = Markify::VERSION
  spec.authors       = ["Daniel Meißner"]
  spec.email         = ["meise+markify@3st.be"]
  spec.description   = Markify::DESCRIPTION
  spec.summary       = Markify::DESCRIPTION
  spec.homepage      = "https://github.com/meise/markify"
  spec.license       = "GPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency('rspec', '~> 2.11.0')
end
