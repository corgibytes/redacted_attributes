# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redacted_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "redacted_attributes"
  spec.version       = RedactedAttributes::VERSION
  spec.authors       = ["M. Scott Ford"]
  spec.email         = ["scott@corgibytes.com"]
  spec.summary       = %q{Stores redacted plain text version of an encrypted value}
  spec.description   = %q{If you find yourself encrypting a value that you need to sort by, then this gem might help. It stores a redacted version of the string, the first three characters, in another column.}
  spec.homepage      = ""
  spec.license       = "Apache License v2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'symmetric-encryption', '~> 3.3'
  spec.add_dependency 'activerecord', '~> 3.2.13'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", '~> 10.1'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'sqlite3', '~> 1.3.8'
end
